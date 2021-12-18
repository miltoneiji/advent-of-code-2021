class Solution
  def char_to_points(char)
    {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }[char]
  end

  def close_char(char)
    {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
    }[char]
  end

  def get_completion_string(input)
    stack = []

    input.chars.each do |char|
      if ['(', '[', '{', '<'].include? char
        stack.push(char)
      else
        top = stack.pop
        return [] unless [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']].include? [top, char]
      end
    end

    stack.reverse.map { |c| close_char(c) }
  end

  def get_points(input)
    get_completion_string(input)
      .reduce(0) { |acc, char| acc * 5 + char_to_points(char) }
  end
end

solution = Solution.new
scores = []
File.readlines('input').map(&:chomp).each do |line|
  score = solution.get_points(line)
  scores.push(score) if score != 0
end

puts scores.sort[scores.length / 2]
