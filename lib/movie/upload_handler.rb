require 'open3'

module Movie::UploadHandler
  class << self
    def save_file(io)
      uploaded_file = io.tempfile
      extension = io.original_filename.split('.').last

      hash = Digest::MD5.file(uploaded_file).hexdigest
      file_name = "#{hash}.#{extension}"
      destination_path = "#{Settings.movie.storage}/#{file_name}"

      `cp #{io.path} #{destination_path}`
      file_name
    end

    def detect_duration(file_path)
      stdin, stdout, stderr = Open3.popen3 "ffmpeg -i #{file_path}"
      info = stderr.read
      matched = /Duration: (\d+):(\d+):([\d\.]+),/.match info
      matched[1..-1].reverse.each_with_index.map do |digits, i|
        60.0**i * digits.to_f
      end.inject(:+)
    end
  end
end
