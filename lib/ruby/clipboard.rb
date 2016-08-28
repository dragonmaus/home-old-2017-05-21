require 'open3'

# Public: Access the OS X clipboard.
module Clipboard
  module_function

  # Public: Clear the clipboard.
  #
  # Returns nothing.
  def clear
    copy ''
  end

  # Public: Set the clipboard.
  #
  # data - The String data to copy into the clipboard.
  #
  # Returns the new contents of the clipboard as a String.
  def copy(data)
    Open3.popen3('pbcopy') { |i, _, _, _| i << data }
    paste
  end

  # Public: Get the contents of the clipboard.
  #
  # Returns the contents of the clipboard as a String.
  def paste
    Open3.popen3('pbpaste') { |_, o, _, _| o.read }
  end
end
