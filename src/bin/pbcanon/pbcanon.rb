#!/usr/local/bin/ruby

require "canon"
require "clipboard"

input = Clipboard.paste
exit if String(input).empty?

input.chomp!

puts input

uri = Addressable::URI.parse(input)
uri = Addressable::URI.parse("http://#{input}") if uri.scheme.nil?

output = uri.canonical.to_s

puts Clipboard.copy(output) unless output == input
