# [[1, 2]   => [[3, 4],
#  [3, 4]]      [1, 2]]
def reverse_vertically(matrix)
  matrix.reverse
end

def merge(matrix_a, matrix_b)
  matrix_a.zip(matrix_b).map do |row_a, row_b|
    row_a.zip(row_b).map do |a, b|
      a || b
    end
  end
end

def fold_vertically(matrix, y)
  top = matrix.take(y)
  bottom = matrix.drop(y + 1)

  top_reversed = reverse_vertically(top)
  reversed_output = merge(top_reversed, bottom)
  reverse_vertically(reversed_output)
end

def fold_horizontally(matrix, x)
  transposed = matrix.transpose
  transposed_answer = fold_vertically(transposed, x)
  transposed_answer.transpose
end

def apply_fold(input, instruction)
  value = instruction.split('=').last.to_i

  if instruction.start_with?('x=')
    fold_horizontally(input, value)
  else
    fold_vertically(input, value)
  end
end

def number_of_dots(matrix)
  count = 0
  matrix.each do |row|
    row.each do |cell|
      count += 1 if cell
    end
  end
  count
end

def pretty_print(matrix)
  matrix.each do |line|
    line.each do |e|
      if e
        print('# ')
      else
        print('. ')
      end
    end
    puts ''
  end
end

input = Array.new(10000) { Array.new(10000, false) }
instructions = []
File.readlines('input').map(&:chomp).each do |line|
  next if line.empty?

  if line.start_with?('fold along ')
    instructions.push(line.split('fold along ').last)
  else
    coords = line.split(',').map(&:to_i)
    x = coords[0]
    y = coords[1]

    input[y][x] = true
  end
end

matrix = instructions.reduce(input) { |input, instruction| apply_fold(input, instruction) }
pretty_print(matrix)
answer = number_of_dots(matrix)
puts answer
