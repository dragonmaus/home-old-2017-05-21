#!/usr/local/bin/ruby

require "addressable/uri"

while line = gets do
  puts Addressable::URI.parse(line.chomp).normalize
end
