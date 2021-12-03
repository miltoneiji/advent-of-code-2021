lines = []
File.readlines('input', chomp: true).each do |line|
  lines.push(line)
end

gamma = 0
epsilon = 0
(0...lines[0].length).each do |index|
  zero_count = 0
  one_count = 0

  lines.each do |binary|
    if binary[index] == '0'
      zero_count = zero_count + 1
    else
      one_count = one_count + 1
    end
  end

  if one_count > zero_count
    gamma = gamma * 2 + 1
    epsilon = epsilon * 2
  else
    gamma = gamma * 2
    epsilon = epsilon * 2 + 1
  end
end

puts gamma * epsilon
