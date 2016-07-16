#!/usr/local/bin/ruby

require 'addressable/uri'

while (line = gets)
  puts Addressable::URI.parse(line.chomp).normalize
end
