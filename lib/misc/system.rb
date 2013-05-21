module System
  def System.exec(command_string)
    print "#{command_string}\n"
    raise unless system command_string
  end
end
