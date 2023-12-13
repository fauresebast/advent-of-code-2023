module Day11
  def self.parse(input)
    input.split("\n").map(&:chars)
  end

  def self.empty_rows(universe)
    universe.each_with_index.filter { |r, i| r.count(".") == r.size }.to_h { |r, i| [i, true] }
  end

  def self.compute(input, coef)
    universe = parse(input)
    doubling_rows = empty_rows(universe)
    doubling_cols = empty_rows(universe.transpose)
    galaxies = []
    (0...universe.size).each do |row|
      (0...universe[0].size).each do |col|
        galaxies << [row, col] if universe[row][col] == "#"
      end
    end
    total_path_size = 0
    (0...galaxies.size).each do |start_index|
      start = galaxies[start_index]
      (start_index + 1...galaxies.size).each do |goal_index|
        goal = galaxies[goal_index]
        total_path_size += (start[0] - goal[0]).abs + (start[1] - goal[1]).abs
        start_row, end_row = [start[0], goal[0]].sort
        (start_row + 1...end_row).each { |r| total_path_size += coef - 1 if doubling_rows[r] }
        start_col, end_col = [start[1], goal[1]].sort
        (start_col + 1...end_col).each { |r| total_path_size += coef - 1 if doubling_cols[r] }
      end
    end
    total_path_size
  end

  def self.part1(input)
    compute(input, 2)
  end

  def self.part2_sample(input)
    compute(input, 10)
  end

  def self.part2(input)
    compute(input, 1000000)
  end
end
