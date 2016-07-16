#!/usr/local/bin/ruby

require 'canon'

while (line = gets)
  uri = Addressable::URI.parse(line.chomp)
  uri = Addressable::URI.parse("http://#{line.chomp}") if uri.scheme.nil?
  puts uri.canonical
end
