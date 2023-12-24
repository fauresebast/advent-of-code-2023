require "active_support/all"

module Day22
  class Brick
    attr_reader :start_x, :start_y, :end_x, :end_y
    attr_accessor :start_z, :end_z, :supports, :supported_by

    def initialize(a, b, c, d, e, f)
      @start_x, @start_y, @start_z = a, b, c
      @end_x, @end_y, @end_z = d, e, f
      @supports = []
      @supported_by = []
    end

    def collision(brick, new_start_z, new_end_z)
      ((
          (@start_x..@end_x).overlaps?(brick.start_x..brick.end_x) ||
            (@start_y..@end_y).overlaps?(brick.start_y..brick.end_y)
        ) && (@start_z..@end_z).overlaps?(new_start_z..new_end_z))
    end
  end

  def self.parse(input)
    input.split("\n").map do |line|
      start_coord, end_coord = line.split("~")
      a, b, c = start_coord.split(",").map(&:to_i)
      d, e, f = end_coord.split(",").map(&:to_i)
      Brick.new(a, b, c, d, e, f)
    end.sort_by(&:end_z)
  end

  # 1175 is too high
  def self.part1(input)
    bricks = parse(input)
    placed = []
    bricks.each do |brick|
      while (brick.start_z - 1) > 0 && placed.none? { |p_brick| p_brick.collision(brick, brick.start_z - 1, brick.end_z - 1) }
        brick.start_z -= 1
        brick.end_z -= 1
      end
      placed.each do |p_brick|
        next unless p_brick.collision(brick, brick.start_z - 1, brick.end_z - 1)
        p_brick.supports << brick
        brick.supported_by << p_brick
      end
      placed << brick
    end
    placed.count { |b| b.supports.empty? || b.supports.all? { |k| k.supported_by.size > 1 } }
  end

  def self.part2(input)
  end
end
