#!/usr/local/bin/ruby

require "clipboard"
require "derpi"

def format(name)
  Derpi.link("artist:#{name}")
end

old = ARGV[0].downcase
new = ARGV[1].downcase

puts Clipboard.copy("(\"DA\":http://#{old}.deviantart.com/) #{format(old)} -> #{format(new)}")
