module Day02
  def self.parse(input)
    input.split("\n").map do |line|
      _, data = line.split(":")
      data.split(";").map do |set|
        set.split(",").map { |c|
          n, color = c.split
          [n.to_i, color]
        }
      end
    end
  end

  def self.part1(input)
    to_match = {"red" => 12, "green" => 13, "blue" => 14}
    parse(input).map.with_index(1) do |game, index|
      (game.all? do |sets|
        sets.all? do |n, color|
          n <= to_match[color]
        end
      end) ? index : 0
    end.sum
  end

  def self.part2(input)
    parse(input).map do |game|
      pairs = game.flatten.each_slice(2).to_a
      best = {"red" => 0, "green" => 0, "blue" => 0}
      pairs.each do |n, color|
        best[color] = [best[color], n].max
      end
      best.values.reduce(:*)
    end.sum
  end
end
