#!/usr/local/bin/ruby

require "derpi"

while line = gets do
  puts Derpi::link(line.chomp)
end
