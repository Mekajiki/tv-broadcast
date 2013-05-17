#!/usr/bin/env ruby
def system_command(command_string)
  print "#{command_string}\n"
  raise unless system command_string
end
