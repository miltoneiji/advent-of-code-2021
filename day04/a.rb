class Board
  def initialize(numbers)
    @numbers = numbers
    @marked = Array.new(5) { Array.new(5) { false } }
    @last_marked_number = nil
  end

  def mark(number)
    if @numbers.include? number
      @last_marked_number = number
      row = @numbers.index(number) / 5
      col = @numbers.index(number) % 5
      @marked[row][col] = true
    end
  end

  def won?
    # checking all rows
    @marked.each do |row|
      if row.all?
        return true
      end
    end

    # checking all cols
    (0...5).each do |col|
      if @marked.map { |row| row[col] }.all?
        return true
      end
    end

    return false
  end

  def score
    sum = 0
    @numbers.each_with_index do |number, index|
      row = index / 5
      col = index % 5
      unless @marked[row][col]
        sum = sum + number
      end
    end

    return sum * @last_marked_number
  end
end

file = File.open('input', 'r')
numbers = file.gets.split(',').map(&:to_i)
boards = []

while (line = file.gets)
  if line.split(' ').length == 5
    input = line.split(' ').map(&:to_i)
    (0...4).each do |_|
      line = file.gets
      input = input + line.split(' ').map(&:to_i)
    end
    boards << Board.new(input)
  end
end

numbers.each do |number|
  boards.each do |board|
    board.mark(number)
    if board.won?
      puts board.score
      exit
    end
  end
end
