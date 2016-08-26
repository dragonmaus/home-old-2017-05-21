#!/usr/bin/env ruby

require 'clipboard'
require 'derpi'

input = Clipboard.paste
exit if String(input).empty?

input.chomp!

puts input

exit unless input.include?('.') || input.include?('/')

uri = Addressable::URI.parse(input)
uri = Addressable::URI.parse("http://#{input}") if uri.scheme.nil?

output = uri.canonical.to_s

puts Clipboard.copy(output) unless output == input
