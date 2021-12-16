def next_state(state)
  output = []
  new_cells = 0
  state.each do |cell|
    cell = cell - 1
    if cell < 0
      output.push(6)
      new_cells = new_cells + 1
    else
      output.push(cell)
    end
  end

  (1..new_cells).each { |_| output.push(8) }

  return output
end

days = 80
state = File.open('input', &:readline).split(',').map(&:to_i)
(1..days).each do |day|
  state = next_state(state)
end
puts state.size
