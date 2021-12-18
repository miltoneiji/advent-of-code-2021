class Solution
  attr_reader :flashes, :all_flashed

  def initialize(state)
    @state = state
    @all_flashed = false
  end

  def next_step
    increase_energy_levels
    flash
  end

  def print_state
    @state.each do |row|
      row.each do |e|
        print "#{e} "
      end
      puts ''
    end
  end

  private

  def increase_energy_levels
    @state = @state.map { |row| row.map { |e| e + 1 } }
  end

  def flash
    flash_happened = true

    while flash_happened
      flash_happened = false
      @state.each_with_index do |row, row_idx|
        row.each_with_index do |e, col_idx|
          next if e <= 9

          flash_happened = true
          @state[row_idx][col_idx] = 0
          neighbors(row_idx, col_idx).each { |r, c| @state[r][c] += 1 if @state[r][c] != 0 }
        end
      end
    end

    @all_flashed = true if all_flashed?
  end

  def all_flashed?
    @state.all? { |row| row.all?(&:zero?) }
  end

  def neighbors(row_idx, col_idx)
    n_rows = @state.length
    n_cols = @state[0].length

    [[-1, 0], [-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1]]
      .map { |drow, dcol| [row_idx + drow, col_idx + dcol] }
      .select { |row, col| row >= 0 && row < n_rows and col >= 0 && col < n_cols }
  end
end

input = []
File.readlines('input').map(&:chomp).each do |line|
  input.push(line.split('').map(&:to_i))
end

solution = Solution.new(input)
counter = 0
until solution.all_flashed
  counter += 1
  solution.next_step
end

puts counter
