#!/usr/local/bin/ruby

require 'addressable/uri'

while (line = gets)
  unless line.include?('.') || line.include?('/')
    puts line.chomp
    next
  end
  puts Addressable::URI.parse(line.chomp).normalize
end
