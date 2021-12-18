def points(char)
  {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
  }[char] || 0
end

def analyze(input)
  stack = []

  input.chars.each do |char|
    if ['{', '(', '[', '<'].include? char
      stack.push(char)
    else
      top = stack.pop
      return char unless [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']].include? [top, char]
    end
  end

  nil
end

syntax_error_score = 0
File.readlines('input').map(&:chomp).each do |line|
  syntax_error_score += points(analyze(line))
end

puts syntax_error_score
