require 'set'

class Solution
  attr_reader :paths

  def initialize
    @caves = {}
    @paths = Set.new
  end

  def read(relation)
    caves = relation_to_caves(relation)

    add_cave(caves.first)
    add_cave(caves.last)

    add_connection(caves.first, caves.last)
  end

  # very very ugly
  def find_paths(current_cave, path, allowed_small_cave, counter)
    path.push(current_cave)
    counter += 1 if current_cave == allowed_small_cave

    if current_cave == 'end'
      @paths.add(path)
    else
      next_caves = @caves[current_cave].select do |neighbor|
        if neighbor == 'start'
          false
        elsif neighbor == neighbor.upcase
          true
        elsif neighbor == allowed_small_cave && counter < 2
          true
        else
          !(path.include? neighbor)
        end
      end

      next_caves.each { |cave| find_paths(cave, path + [cave], allowed_small_cave, counter) }
    end
  end

  def small_caves
    @caves.keys.reject { |cave| cave == cave.upcase }
  end

  private

  def relation_to_caves(relation)
    relation.split('-')
  end

  def add_cave(cave)
    @caves[cave] = [] unless @caves.key?(cave)
  end

  def add_connection(cave_a, cave_b)
    @caves[cave_a].push(cave_b) unless @caves[cave_a].include? cave_b
    @caves[cave_b].push(cave_a) unless @caves[cave_b].include? cave_a
  end
end

solution = Solution.new

File.readlines('input').map(&:chomp).each do |line|
  solution.read(line)
end

solution.small_caves.each do |small_cave|
  solution.find_paths('start', ['start'], small_cave, 0)
end
puts solution.paths.size
