horizontal = 0
depth = 0
aim = 0

File.readlines('input').each do |line|
  tokens = line.split(' ')
  command = tokens[0]
  value = tokens[1].to_i

  case command
  when "down"
    aim = aim + value
  when "up"
    aim = aim - value
  when "forward"
    horizontal = horizontal + value
    depth = depth + aim * value
  end
end

puts horizontal * depth
