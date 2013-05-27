require 'open3'
require 'lockfile'

TSSPLITTER_PATH = Settings.movie.tssplitter.path
TSSPLITTER_OPTION = Settings.movie.tssplitter.option

FFMPEG_OPTION = Settings.movie.ffmpeg.option
FFMPEG_PRESET_PATH = Settings.movie.ffmpeg.preset_path

module Movie::Encoder
  class << self
    def encode(source, out, other_options = '')
      lockfile = Lockfile.new Settings.movie.lock_file_path

      begin
        lockfile.lock

        # split ts
        System.exec "wine #{TSSPLITTER_PATH} #{TSSPLITTER_OPTION} '#{source}'"

        Dir.chdir File.dirname(source)
        biggest_size = 0
        Dir.glob('*_HD*.ts').each do |file|
          if File.size(file) > biggest_size
            biggest_size = File.size(file)
            @splitted_source = File.basename(source, '.ts') + "_HD.ts"
          end
        end

        @splitted_source ||= File.basename(source)

        #detect which streams to map
        stdin, stdout, stderr = Open3.popen3 "ffmpeg -i #{@splitted_source}"
        ng_words = ['Unknown', '0 channels']
        stream_ids = []
        err_string = stderr.read.encode('UTF-16BE', 'UTF-8', :invalid => :replace, :undef => :replace, :replace => '?').encode('UTF-8')
        err_string.each_line do |line|
          if match = /\s*Stream #(\d+:\d+)\[.+/.match(line)
            if ng_words.map{|ng_word| !line.index(ng_word)}.reduce(&:&)
              stream_ids.push(match[1])
            end
          end
        end
        map = stream_ids.map{|stream_id| '-map ' + stream_id}.join(' ')

        # encode
        System.exec "ffmpeg -y -i #{@splitted_source} #{map} #{other_options} #{FFMPEG_OPTION} -fpre #{FFMPEG_PRESET_PATH} tmp.mp4"

        System.exec "qt-faststart tmp.mp4 #{out}"
      rescue Exception => ex
        puts ex.message
        puts ex.backtrace.join("\n")
      ensure
        lockfile.unlock
      end
    end
  end
end
