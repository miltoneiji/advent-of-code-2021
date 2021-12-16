count = 0

File.readlines('input').each do |line|
  output_values = line.split('|').last.strip.split(' ')

  output_values.each do |signal|
    if [2, 4, 3, 7].include? signal.length
      count = count + 1
    end
  end
end

puts count
