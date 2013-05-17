#!/usr/bin/env ruby
require 'open3'
require 'lockfile'
require Rails.root.join('bin', 'helper.rb')

TSSPLITTER_PATH = Settings.movie.tssplitter.path
TSSPLITTER_OPTION = Settings.movie.tssplitter.option

FFMPEG_OPTION = Settings.movie.ffmpeg.option
FFMPEG_PRESET_PATH = Settings.movie.ffmpeg.preset_path

unless ARGV.length == 2
  print "usage: #{$0} input_file output_file\n"
  abort
end

lockfile = Lockfile.new '/tmp/encode.lock'

begin
  lockfile.lock

  source = ARGV[0]
  out = ARGV[1]
  # split ts
  system_command "wine #{TSSPLITTER_PATH} #{TSSPLITTER_OPTION} '#{source}'"

  Dir.chdir File.dirname(source)
  biggest_size = 0
  splitted_source = ''
  Dir.glob('*_HD*.ts').each do |file|
    if File.size(file) > biggest_size
      biggest_size = File.size(file)
      splitted_source = File.basename(source, '.ts') + "_HD.ts"
    end
  end

  #detect which streams to map
  stdin, stdout, stderr = Open3.popen3 "epgdump json #{splitted_source} -"
  program_info = JSON.parse(stdout.read)

  stdin, stdout, stderr = Open3.popen3 "ffmpeg -i #{splitted_source}"
  ng_words = ['Unknown', '0 channels']
  stream_ids = []
  stderr.each_line do |line|
    if match = /\s*Stream #(\d+:\d+)\[.+/.match(line)
      if ng_words.map{|ng_word| !line.index(ng_word)}.reduce(&:&)
        stream_ids.push(match[1])
      end
    end
  end
  map = stream_ids.map{|stream_id| '-map ' + stream_id}.join(' ')

  # encode
  # TODO: tune
  system_command "ffmpeg -y -i #{splitted_source} #{map} #{FFMPEG_OPTION} -fpre #{FFMPEG_PRESET_PATH} #{out}"

  system_command "qt-faststart #{out}"
ensure
  lockfile.unlock
end
