#!/usr/bin/env ruby
require 'uri'
require 'open3'
require Rails.root.join('app', 'helpers', 'script_helper.rb')

unless ARGV.length == 1
  print "usage: #{$0} FILE \n"
  abort
end

escaped_name = Digest::MD5.file(ARGV[0]).hexdigest
source_file_name = escaped_name + ".ts"
work_dir = Settings.movie.workspace + Digest::MD5.hexdigest File.basename(ARGV[0], '.ts')
Dir.mkdir work_dir
system_command "mv #{ARGV[0]} #{work_dir}/#{source_file_name}"
Dir.chdir work_dir

stdin, stdout, stderr = Open3.popen3 "epgdump json #{source_file_name} -"
epg = JSON.parse(stdout.read)
program_info = epg[0]['programs'].find do |info|
  ARGV[0].index info['title'].split('【')[0]
end
p program_info

dist_path = "#{Settings.movie.storage}/#{escaped_name}.mp4"
system_command "#{Settings.rvm_wrapper} runner #{Rails.root.join('bin', 'encode.rb')} \
                #{source_file_name} \
                #{dist_path}"
