arr = File.open('input', &:readline).split(',').map(&:to_i)

answer = nil

(arr.min..arr.max).each do |guess|
  fuel = arr.reduce(0) do |sum, n|
    diff = (n - guess).abs
    sum + diff*(diff + 1)/2
  end

  if answer == nil or answer > fuel
    answer = fuel
  end
end

puts answer
