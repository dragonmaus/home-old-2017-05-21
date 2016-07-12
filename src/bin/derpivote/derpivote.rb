#!/usr/local/bin/ruby

require "clipboard"

unless ARGV.length == 3
  warn "usage: derpivote <first> <second> <third>"
  exit 100
end

a = ARGV[0].match(/(\d+)/)[1]
b = ARGV[1].match(/(\d+)/)[1]
c = ARGV[2].match(/(\d+)/)[1]

puts Clipboard.copy(">>#{a} - 4\n>>#{b} - 2\n>>#{c} - 3\n>>#{a}t >>#{b}s >>#{c}s")
