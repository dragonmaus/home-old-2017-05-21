# frozen_string_literal: true
def sort(object)
  case object
  when Hash
    object.map { |k, v| [k, sort(v)] }.sort.to_h
  when Array
    begin
      object.sort_by { |e| sort(e) }
    rescue
      object.map { |e| sort(e) }
    end
  else
    object
  end
end
