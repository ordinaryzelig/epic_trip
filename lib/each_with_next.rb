class Array

  # Iterate through each element also yielding the next element.
  def each_with_next
    each_with_index do |ele, index|
      yield ele, self[index + 1]
    end
  end

end
