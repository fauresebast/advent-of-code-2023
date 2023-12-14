module Day14
  def self.parse(input)
    input.split("\n")
  end

  def self.part1(input)
    grid = parse(input)
    height, width = grid.size, grid[0].size
    rounded_rocks_rows, rounded_rocks, cube_rocks = [], {}, {}
    (0...height).each do |r|
      (0...width).each do |c|
        if grid[r][c] == "#"
          cube_rocks[[r, c]] = true
        elsif grid[r][c] == "O"
          k = r
          (k -= 1) until k.zero? || cube_rocks[[k - 1, c]] || rounded_rocks[[k - 1, c]]
          rounded_rocks[[k, c]] = true
          rounded_rocks_rows << height - k
        end
      end
    end
    rounded_rocks_rows.sum
  end

  def self.print_grid(height, width, rounded_rocks, cube_rocks)
    (0...height).each do |r|
      l = ""
      (0...width).each do |c|
        l += if rounded_rocks.include?([r, c])
          "O"
        else
          (cube_rocks[[r, c]] ? "#" : ".")
        end
      end
      puts l
    end
    puts
  end

  def self.part2(input)
    grid = parse(input)
    height, width = grid.size, grid[0].size
    rounded_rocks, cube_rocks = [], {}
    (0...height).each do |r|
      (0...width).each do |c|
        if grid[r][c] == "#"
          cube_rocks[[r, c]] = true
        elsif grid[r][c] == "O"
          rounded_rocks << [r, c]
        end
      end
    end
    seen_state = {}
    seen_state[rounded_rocks] = 0
    (1..).each do |step|
      current_rolling_rocks = {}
      rounded_rocks = rounded_rocks.sort.map do |r, c| # ROLLING NORTH
        (r -= 1) until r.zero? || cube_rocks[[r - 1, c]] || current_rolling_rocks[[r - 1, c]]
        current_rolling_rocks[[r, c]] = true
        [r, c]
      end
      current_rolling_rocks = {}
      rounded_rocks = rounded_rocks.sort_by(&:last).map do |r, c| # ROLLING WEST
        (c -= 1) until c.zero? || cube_rocks[[r, c - 1]] || current_rolling_rocks[[r, c - 1]]
        current_rolling_rocks[[r, c]] = true
        [r, c]
      end
      current_rolling_rocks = {}
      rounded_rocks = rounded_rocks.sort_by { |r, _| -r }.map do |r, c| # ROLLING SOUTH
        (r += 1) until r >= height - 1 || cube_rocks[[r + 1, c]] || current_rolling_rocks[[r + 1, c]]
        current_rolling_rocks[[r, c]] = true
        [r, c]
      end
      current_rolling_rocks = {}
      rounded_rocks = rounded_rocks.sort_by { |_, c| -c }.map do |r, c| # ROLLING EAST
        (c += 1) until c >= width - 1 || cube_rocks[[r, c + 1]] || current_rolling_rocks[[r, c + 1]]
        current_rolling_rocks[[r, c]] = true
        [r, c]
      end

      if seen_state[rounded_rocks.sort]
        cycle_start = seen_state[rounded_rocks.sort]
        cycle_size = step - cycle_start
        from_cycle_start = (1_000_000_000 - cycle_start) % cycle_size

        final_state = seen_state.invert[cycle_start + from_cycle_start]
        return final_state.sum { |r, _| height - r }
      else
        seen_state[rounded_rocks.sort] = step
      end
    end
  end
end
