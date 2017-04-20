# frozen_string_literal: true

class Object
  def diff_methods(other)
    __send__(:methods).select { |s| s.to_s.end_with?('methods') && s != :diff_methods }.sort.map do |m|
      if other.respond_to?(m)
        [m, __send__(m).reject { |s| other.__send__(m).include?(s) }.sort]
      else
        [m, __send__(m).sort]
      end
    end.to_h
  end
end
