#!/usr/local/bin/ruby

require "derpi"

while line = gets do
  uri = Addressable::URI.parse(line.chomp)
  uri = Addressable::URI.parse("http://#{line.chomp}") if uri.scheme.nil?
  puts uri.canonical
end
