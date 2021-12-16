def get_possibilities(input)
  possibilities = {
    1 => ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    2 => ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    3 => ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    4 => ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    5 => ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    6 => ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
    7 => ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
  }

  input.each do |combination|
    if combination.length == 2
      possibilities[3].keep_if { |c| combination.include? c }
      possibilities[6].keep_if { |c| combination.include? c }
    elsif combination.length == 3
      possibilities[1].keep_if { |c| combination.include? c }
      possibilities[3].keep_if { |c| combination.include? c }
      possibilities[6].keep_if { |c| combination.include? c }
    elsif combination.length == 4
      possibilities[2].keep_if { |c| combination.include? c }
      possibilities[4].keep_if { |c| combination.include? c }
      possibilities[3].keep_if { |c| combination.include? c }
      possibilities[6].keep_if { |c| combination.include? c }
    elsif combination.length == 5
      possibilities[1].keep_if { |c| combination.include? c }
      possibilities[4].keep_if { |c| combination.include? c }
      possibilities[7].keep_if { |c| combination.include? c }
    elsif combination.length == 6
      possibilities[1].keep_if { |c| combination.include? c }
      possibilities[2].keep_if { |c| combination.include? c }
      possibilities[6].keep_if { |c| combination.include? c }
      possibilities[7].keep_if { |c| combination.include? c }
    end
  end
  
  while possibilities.any? { |k, v| v.length != 1 }
    certain = possibilities.select { |k, v| v.length == 1 }.map { |k, v| v[0] }
    (1..7).each do |segment|
      if possibilities[segment].length != 1
        possibilities[segment].delete_if { |c| certain.include? c }
      end
    end
  end
  
  return possibilities
end

def string_to_number(input, possibilities, segments_to_number)
  segments = input.chars.map { |c| possibilities.find { |_, v| v.first == c }.first }.sort()
  return segments_to_number[segments]
end

def solve(raw_input)
  patterns = raw_input.split("|").first.strip().split(" ")
  possibilities = get_possibilities(patterns)
  output = raw_input.split("|").last.strip().split(" ")

  segments_to_number = {
    [1, 2, 3, 5, 6, 7] => 0,
    [3, 6] => 1,
    [1, 3, 4, 5, 7] => 2,
    [1, 3, 4, 6, 7] => 3,
    [2, 3, 4, 6] => 4,
    [1, 2, 4, 6, 7] => 5,
    [1, 2, 4, 5, 6, 7] => 6,
    [1, 3, 6] => 7,
    [1, 2, 3, 4, 5, 6, 7] => 8,
    [1, 2, 3, 4, 6, 7] => 9,
  }

  return output.reduce(0) { |sum, string| 10 * sum + string_to_number(string, possibilities, segments_to_number) }
end

output = 0
File.readlines('input').each do |line|
  output = output + solve(line)
end
puts output
