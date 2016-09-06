#!/usr/bin/env ruby
# frozen_string_literal: true

require 'clipboard'
require 'derpi'

def clean(string)
  string.downcase.sub(/^artist:/)
end

def format(name)
  Derpi.link("artist:#{name}")
end

old = clean(ARGV[0])
new = clean(ARGV[0])

puts Clipboard.copy(format('"DA":http://%s.deviantart.com/ %s -> %s',
                           old, format(old), format(new)))
