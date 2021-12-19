require 'set'

class Solution
  attr_reader :paths
  attr_writer :allowed_small_cave

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

  def find_paths(current_cave, path, allowed_small_cave_visits = 0)
    path.push(current_cave)
    allowed_small_cave_visits += 1 if current_cave == @allowed_small_cave

    if current_cave.end_cave?
      @paths.add(path)
    else
      next_caves = neighbors(current_cave).select do |neighbor|
        valid_neighbor?(neighbor, allowed_small_cave_visits, path)
      end

      next_caves.each { |cave| find_paths(cave, path + [cave], allowed_small_cave_visits) }
    end
  end

  def small_caves
    @caves.keys.select(&:small?)
  end

  private

  def valid_neighbor?(neighbor, allowed_small_cave_visits, path)
    if neighbor.start_cave?
      false
    elsif neighbor.big?
      true
    elsif neighbor == @allowed_small_cave && allowed_small_cave_visits < 2
      true
    else
      !(path.include? neighbor)
    end
  end

  def relation_to_caves(relation)
    relation.split('-').map { |name| Cave.new(name) }
  end

  def add_cave(cave)
    @caves[cave] = [] unless @caves.key?(cave)
  end

  def add_connection(cave_a, cave_b)
    @caves[cave_a].push(cave_b) unless @caves[cave_a].include? cave_b
    @caves[cave_b].push(cave_a) unless @caves[cave_b].include? cave_a
  end

  def neighbors(cave)
    @caves[cave]
  end
end

class Cave
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def big?
    @name == @name.upcase
  end

  def small?
    !big? && !start_cave?
  end

  def end_cave?
    name == 'end'
  end

  def start_cave?
    name == 'start'
  end

  def hash
    name.hash
  end

  def eql?(other)
    other.name == name
  end

  def ==(other)
    other.name == name
  end
end

solution = Solution.new

File.readlines('input').map(&:chomp).each do |line|
  solution.read(line)
end

initial_cave = Cave.new('start')
solution.small_caves.each do |small_cave|
  solution.allowed_small_cave = small_cave
  solution.find_paths(initial_cave, [initial_cave])
end
puts solution.paths.size
