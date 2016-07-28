#!/usr/local/bin/ruby

require 'derpi'

while (line = gets)
  unless line.include?('.') || line.include?('/')
    puts line.chomp
    next
  end
  uri = Addressable::URI.parse(line.chomp)
  uri = Addressable::URI.parse("http://#{line.chomp}") if uri.scheme.nil?
  puts uri.canonical
end
