values = []

File.readlines('input').each do |line|
  value = line.to_i
  values.push(value)
end

increases = 0
left = 0
right = -1
curr_sum = -1
previous_sum = 1000000000

while right < values.size - 1
  right = right + 1
  curr_sum = curr_sum + values[right]

  if right - left + 1 > 3
    curr_sum = curr_sum - values[left]
    left = left + 1
  end

  if right - left + 1 == 3
    if curr_sum > previous_sum
      increases = increases + 1
    end
    previous_sum = curr_sum
  end
end

puts increases
