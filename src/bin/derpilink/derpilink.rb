#!/usr/bin/env ruby
# frozen_string_literal: true

require 'derpi'

while (line = gets)
  puts Derpi.link(line.chomp)
end
