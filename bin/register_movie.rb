#!/usr/bin/env ruby
require 'uri'
require 'open3'
require 'nkf'
require Rails.root.join('bin', 'helper.rb')

unless ARGV.length == 1
  print "usage: #{$0} FILE \n"
  abort
end

escaped_name = Digest::MD5.file(ARGV[0]).hexdigest
source_file_name = escaped_name + ".ts"
work_dir = Settings.movie.workspace + Digest::MD5.hexdigest(File.basename(ARGV[0], '.ts'))
Dir.mkdir work_dir
begin
  system_command "mv #{ARGV[0]} #{work_dir}/#{source_file_name}"

  stdin, stdout, stderr = Open3.popen3 "epgdump json #{work_dir}/#{source_file_name} -"
  epg = JSON.parse(stdout.read)
  program_info = epg[0]['programs'].find do |info|
    NKF.nkf('-m0Z1 -w', ARGV[0]).index NKF.nkf('-m0Z1 -w', info['title'].split('【')[0])
  end
  p program_info
  raise unless program_info

  dist_path = "#{Settings.movie.storage}/#{escaped_name}.mp4"
  system_command "#{Settings.rvm_wrapper} runner #{Rails.root.join('bin', 'encode.rb')} \
  #{work_dir}/#{source_file_name} \
  #{dist_path}"

  program = Program.new_from_epg(program_info)
  program.movie_path = dist_path
  raise unless program.save
rescue
  STDERR.puts "registration failed: #{ARGV[0]}"
  escape_path = "#{Settings.movie.failed_ts_path}/#{source_file_name}"
  STDERR.puts "save to #{ARGV[0]}"
  system_command "mv #{work_dir}/#{source_file_name} #{escape_path}"
ensure
  system_command "rm -rf #{work_dir}"
end
