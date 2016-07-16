#!/usr/local/bin/ruby

require 'derpi'

while (line = gets)
  puts Derpi.link(line.chomp)
end
