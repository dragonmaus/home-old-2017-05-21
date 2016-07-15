#!/usr/local/bin/ruby

require "clipboard"
require "derpi"

def clean(string)
  string.downcase.sub(/^artist:/)
end

def format(name)
  Derpi.link("artist:#{name}")
end

old = clean(ARGV[0])
new = clean(ARGV[0])

puts Clipboard.copy("(\"DA\":http://#{old}.deviantart.com/) #{format(old)} -> #{format(new)}")
