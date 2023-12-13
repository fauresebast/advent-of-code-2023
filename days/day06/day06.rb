require "set"
module Day06
  def self.parse(input)
    times = input.lines[0].scan(/\d+/).map(&:to_i)
    distances = input.lines[1].scan(/\d+/).map(&:to_i)
    times.zip(distances).to_a
  end

  def self.part1(input)
    total_possibilities = 1
    parse(input).each do |time, record_distance|
      possibilities = 0
      (0..time).each do |hold_time|
        travel_time = time - hold_time
        if travel_time * hold_time > record_distance
          possibilities += 1
        end
      end
      total_possibilities *= possibilities
    end
    total_possibilities
  end

  def self.parse2(input)
    time = input.lines[0].scan(/\d+/).join.to_i
    distance = input.lines[1].scan(/\d+/).join.to_i
    [time, distance]
  end

  def self.naive_part2(input)
    time, record_distance = parse2(input)
    possibilities = 0
    (0..time).each do |hold_time|
      travel_time = time - hold_time
      if travel_time * hold_time > record_distance
        possibilities += 1
      end
    end
    possibilities
  end

  # complexity: O(1)
  def self.part2(input)
    time, record_distance = parse2(input)
    # -x**2 + time * x - record_distance > 0
    a, b, c = -1, time, - record_distance
    delta = b**2 - (4 * a * c)
    x1 = (-b - (delta**0.5).floor) / (2 * a)
    x2 = (-b + (delta**0.5).ceil) / (2 * a)
    (x1 - x2).abs
  end
end
