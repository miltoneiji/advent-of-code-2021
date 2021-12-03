previous_measurement = 1000000000
increases = 0

File.readlines('input').each do |line|
  depth = line.to_i
  if depth > previous_measurement
    increases = increases + 1
  end

  previous_measurement = depth
end

puts increases
