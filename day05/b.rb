def horizontal?(point1, point2)
  return point1[1] == point2[1]
end

def vertical?(point1, point2)
  return point1[0] == point2[0]
end

def generate_range(a, b)
  if a <= b
    return (a..b)
  else
    return a.downto(b)
  end
end

matrix = Array.new(1001) { Array.new(1001) { 0 } }

File.readlines('input').each do |line|
  points = line.split('->').map(&:strip)
  point1 = points[0].split(',').map(&:to_i)
  point2 = points[1].split(',').map(&:to_i)

  if horizontal?(point1, point2)
    xs = generate_range(point1[0], point2[0])
    y = point1[1]
    xs.each do |x|
      matrix[x][y] = matrix[x][y] + 1
    end
  elsif vertical?(point1, point2)
    ys = generate_range(point1[1], point2[1])
    x = point1[0]
    ys.each do |y|
      matrix[x][y] = matrix[x][y] + 1
    end
  else
    xs = generate_range(point1[0], point2[0])
    ys = generate_range(point1[1], point2[1])
    xs.zip(ys).each do |x, y|
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
