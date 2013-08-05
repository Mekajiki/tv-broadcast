module Movie::Gif
  class << self
    def create(source, out, start_at, end_at)
      raise if start_at >= end_at

      prefix = SecureRandom.hex

      Dir.chdir('/tmp')
      System.exec "ffmpeg -ss #{start_at} -i #{source} -r 10 -t #{end_at - start_at} -s #{Settings.gif.resolution} #{prefix}%04d.gif"
      System.exec "convert -delay 10 -loop 1 #{prefix}*.gif #{out}"
    end
  end
end
