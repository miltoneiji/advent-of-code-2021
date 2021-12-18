class Cell
  attr_reader :row, :col

  def initialize(row, col, nrows, ncols)
    @row = row
    @col = col
    @nrows = nrows
    @ncols = ncols
  end

  def neighbors
    directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    directions
      .map { |drow, dcol| Cell.new(@row + drow, @col + dcol, @nrows, @ncols) }
      .select(&:valid?)
  end

  def valid?
    @row >= 0 and @row < @nrows and @col >= 0 and @col < @ncols
  end
end

class Solution
  def initialize(matrix)
    @matrix = matrix
    @basin_sizes = []
  end

  def find_basins
    @matrix.each_with_index do |row, row_idx|
      row.each_with_index do |element, col_idx|
        @basin_sizes.push(flood(row_idx, col_idx)) if element != 9
      end
    end
  end

  def flood(row, col)
    to_visit = [Cell.new(row, col, @matrix.size, @matrix[0].size)]
    basin_size = 0

    while to_visit.any?
      cell = to_visit.pop
      next if @matrix[cell.row][cell.col] == 9

      # visit
      basin_size += 1
      @matrix[cell.row][cell.col] = 9
      # flood
      to_visit.concat(cell.neighbors)
    end

    basin_size
  end

  def solution
    @basin_sizes.sort.reverse.take(3).reduce(1) { |acc, v| acc * v }
  end
end

# read input
matrix = []
File.readlines('input').map(&:chomp).each { |l| matrix.push(l.split('').map(&:to_i)) }

# solve the problem
solution = Solution.new(matrix)
solution.find_basins
puts solution.solution
