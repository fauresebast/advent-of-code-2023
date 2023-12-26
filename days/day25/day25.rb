require 'set'
require 'rgl/adjacency'
require 'rgl/dot'

module Day25
  def self.parse(input)
    links = []
    input.split("\n").each do |line|
      k, connections = line.split(":")
      connections = connections.split
      connections.each {|c| links << [k, c] }
    end
    links.uniq
  end

  def self.part1(input)
    links = parse(input).flatten
    dg=RGL::DirectedAdjacencyGraph[*links]
    dg.write_to_graphic_file('jpg')
  end

  def self.part2(input)
  end
end
