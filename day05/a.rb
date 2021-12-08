def horizontal?(point1, point2)
  return point1[1] == point2[1]
end

def vertical?(point1, point2)
  return point1[0] == point2[0]
end

matrix = Array.new(1001) { Array.new(1001) { 0 } }

File.readlines('input').each do |line|
  points = line.split('->').map(&:strip)
  point1 = points[0].split(',').map(&:to_i)
  point2 = points[1].split(',').map(&:to_i)

  if horizontal?(point1, point2)
    range = point1[0] < point2[0] ? (point1[0]..point2[0]) : (point2[0]..point1[0])
    y = point1[1]
    range.each do |x|
      matrix[x][y] = matrix[x][y] + 1
    end
  elsif vertical?(point1, point2)
    range = point1[1] < point2[1] ? (point1[1]..point2[1]) : (point2[1]..point1[1])
    x = point1[0]
    range.each do |y|
      matrix[x][y] = matrix[x][y] + 1
    end
  end
end

answer = 0
matrix.each do |row|
  row.each do |element|
    if element >= 2
      answer = answer + 1
    end
  end
end

puts answer
