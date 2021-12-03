horizontal = 0
vertical = 0

File.readlines('input').each do |line|
  tokens = line.split(' ')
  command = tokens[0]
  value = tokens[1].to_i

  case command
  when "forward"
    horizontal = horizontal + value
  when "up"
    vertical = vertical - value
  when "down"
    vertical = vertical + value
  end
end

puts horizontal * vertical
