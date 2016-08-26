#!/usr/bin/env ruby

require 'derpi'

while (line = gets)
  puts Derpi.link(line.chomp)
end
