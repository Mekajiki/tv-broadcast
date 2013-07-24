#!/usr/bin/env ruby

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
  end
end
