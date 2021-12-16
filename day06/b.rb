def next_state(state)
  new_fishes = state[0]
  state.shift()
  state[8] = new_fishes
  state[6] = state[6] + new_fishes
  return state
end

state = Array.new(9) { 0 }
input = File.open('input', &:readline).split(',').map(&:to_i)
input.each do |n|
  state[n] = state[n] + 1
end

(1..256).each do |day|
  state = next_state(state)
end
puts state.reduce(:+)
