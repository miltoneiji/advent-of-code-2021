def valid_coordinate?(n_rows, n_cols)
  return ->(row, col) { (row >= 0 and col >= 0 and row < n_rows and col < n_cols) }
end

matrix = []
File.readlines('input').map(&:chomp).each do |line|
  matrix.push(line.split('').map(&:to_i))
end

is_valid = valid_coordinate?(matrix.size, matrix[0].size).curry

directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]
risk_level = 0
matrix.each_with_index do |row, row_idx|
  row.each_with_index do |element, idx|
    is_smaller = true

    directions.each do |direction|
      neighbor_row = row_idx + direction[1]
      neighbor_col = idx + direction[0]

      if is_valid[neighbor_row, neighbor_col] and matrix[neighbor_row][neighbor_col] <= element
        is_smaller = false
      end
    end

    if is_smaller
      risk_level = risk_level + element + 1
    end
  end
end

puts risk_level
