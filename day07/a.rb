def median(arr)
  sorted = arr.sort()
  length = arr.length
  if length.odd?
    return sorted[length/2]
  else
    return (sorted[length/2] + sorted[length/2 - 1])/2
  end
end

def fuel(arr, median)
  return arr.reduce(0) { |sum, n| sum + (median - n).abs }
end

arr = File.open('input', &:readline).split(',').map(&:to_i)
puts fuel(arr, median(arr))
