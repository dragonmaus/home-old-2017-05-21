#!/usr/local/bin/ruby

require "derpi"

while line = gets do
  puts Derpi::slug(line.chomp)
end
