#!/usr/local/bin/ruby

require "clipboard"
require "derpi"

input = Clipboard::paste.chomp
exit if input == ""
puts input
uri = Addressable::URI.parse(input)
uri = Addressable::URI.parse("http://#{input}") if uri.scheme.nil?
output = uri.canonical.to_s
puts Clipboard::copy(output) unless output == input
