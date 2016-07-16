require 'open3'

module Clipboard
  module_function

  def clear
    copy('')
  end

  def copy(data)
    Open3.popen3('pbcopy') { |i, _, _, _| i << data }
    paste
  end

  def paste
    Open3.popen3('pbpaste') { |_, o, _, _| o.read }
  end
end
