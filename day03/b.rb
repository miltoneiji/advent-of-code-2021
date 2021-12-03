def binary_to_decimal(binary_string)
  result = 0
  binary_string.each_char do |char|
    if char == '1'
      result = result * 2 + 1
    else
      result = result * 2
    end
  end
  return result
end

def oxigen_rating(input)
  (0..input[0].length).each do |index|
    if input.length == 1
      break
    end
  
    zero_count = input.select { |bin|
      bin[index] == '0'
    }.length

    one_count = input.select { |bin|
      bin[index] == '1'
    }.length

    if one_count >= zero_count
      input.delete_if { |bin| bin[index] != '1' }
    else
      input.delete_if { |bin| bin[index] != '0' }
    end
  end

  return binary_to_decimal(input[0])
end

def co2_rating(input)
  (0..input[0].length).each do |index|
    if input.length == 1
      break
    end
  
    zero_count = input.select { |bin|
      bin[index] == '0'
    }.length

    one_count = input.select { |bin|
      bin[index] == '1'
    }.length

    if one_count < zero_count
      input.delete_if { |bin| bin[index] != '1' }
    else
      input.delete_if { |bin| bin[index] != '0' }
    end
  end

  return binary_to_decimal(input[0])
end

input = []
File.readlines('input', chomp: true).each do |line|
  input.push(line)
end

puts oxigen_rating(input.dup) * co2_rating(input.dup)
