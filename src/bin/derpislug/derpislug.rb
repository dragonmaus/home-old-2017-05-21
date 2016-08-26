#!/usr/bin/env ruby

require 'derpi'

while (line = gets)
  puts Derpi.slug(line.chomp)
end
