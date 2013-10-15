module Movie::Gif
  class << self
    def create(source, out, start_at, end_at)
      raise if start_at >= end_at

      prefix = SecureRandom.hex

      Dir.chdir('/tmp')
      System.exec "ffmpeg -ss #{start_at} -i #{source} -r 10 -t #{end_at - start_at} -s #{Settings.gif.resolution} #{prefix}%04d.gif"
      System.exec "convert -delay 10 -loop 0 #{prefix}*.gif #{out}"
      System.exec "rm #{prefix}*.gif"
    end

    def convert_program(program, start_at, end_at)
      source = program.movie_absolute_path
      file_name = SecureRandom.hex + '.gif'
      out_path = Settings.gif.storage + '/' + file_name

      create(source, out_path, start_at, end_at)

      return GifAnimation.create(program: program, start_at: start_at, end_at: end_at, file_name: file_name)
    end
  end
end
