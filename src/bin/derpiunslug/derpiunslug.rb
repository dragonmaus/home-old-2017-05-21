#!/usr/bin/env ruby

require 'derpi'

while (line = gets)
  puts Derpi.unslug(line.chomp)
end
