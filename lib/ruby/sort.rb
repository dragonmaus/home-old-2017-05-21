def sort(object)
  case object
  when Hash
    object.map { |k, v| [k, sort(v)] }.sort.to_h
  when Array
    object.sort_by { |e| sort(e) } rescue object.map { |e| sort(e) }
  else
    object
  end
end
