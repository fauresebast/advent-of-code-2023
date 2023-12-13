module Day10
  def self.parse(input)
    grid = input.split("\n")
    start = [0, 0]
    grid.each_with_index do |line, row_index|
      if (col_index = line.index("S"))
        start = [row_index, col_index]
        break
      end
    end
    [start, grid]
  end

  def self.find_loop(start, grid)
    current = start
    seen = {}
    loop do
      seen[current] = seen.size + 1
      right, down, left, up = [[0, 1], [1, 0], [0, -1], [-1, 0]].map { |a, b| [current[0] + a, current[1] + b] }
      rchar, dchar, lchar, uchar = [right, down, left, up].map { (grid[_1] && grid[_1][_2]) || "" }
      current_char = grid[current[0]][current[1]]
      can_go_right, can_go_down, can_go_left, can_go_up = [
        %w[S - L F].include?(current_char),
        %w[S | 7 F].include?(current_char),
        %w[S - J 7].include?(current_char),
        %w[S | J L].include?(current_char)
      ]
      if ((rchar == "S" && can_go_right) || (dchar == "S" && can_go_down) || (lchar == "S" && can_go_left) || (uchar == "S" && can_go_up)) && seen.size > 2
        break
      end
      if !seen[right] && can_go_right && %w[- J 7].include?(rchar)
        current = right
      elsif !seen[down] && can_go_down && %w[| J L].include?(dchar)
        current = down
      elsif !seen[left] && can_go_left && %w[- L F].include?(lchar)
        current = left
      elsif !seen[up] && can_go_up && %w[| 7 F].include?(uchar)
        current = up
      else
        p [current, [rchar, dchar, lchar, uchar]]
        raise NoDirectionFound
      end
    end
    seen
  end

  def self.part1(input)
    start, grid = parse(input)
    seen = find_loop(start, grid)
    seen.size / 2
  end

  def self.part2(input)
    start, grid = parse(input)
    seen = find_loop(start, grid)
    height, width = grid.size, grid[0].size
    enclosed_tiles_count = 0
    # p seen.size
    # (0...height).each do |r|
    #   l = ""
    #   (0...width).each do |c|
    #     l += seen[[r, c]] ? seen[[r, c]].to_s.rjust(4) : ".".rjust(4)
    #   end
    #   puts l
    # end
    # puts ""
    (0...height - 1).each do |row|
      current_chunk = 0
      in_main_loop = false
      # l = ""
      (0...width).each do |col|
        if seen[[row, col]] && seen[[row + 1, col]] && (seen[[row + 1, col]] - seen[[row, col]]).abs == 1
          # this condition pass sample3 and my input
          in_main_loop = seen[[row + 1, col]] > seen[[row, col]]
          # this pass sample2 and sample4
          # in_main_loop = seen[[row+1, col]] < seen[[row, col]]
          if !in_main_loop
            enclosed_tiles_count += current_chunk
            # l += "#".rjust(4)*current_chunk
            current_chunk = 0
          end
          # l += in_main_loop ? "^".rjust(4) : "v".rjust(4)
        elsif in_main_loop && !seen[[row, col]]
          current_chunk += 1
        end
      end
      # l += ".".rjust(4)*current_chunk
      # puts  l
    end
    enclosed_tiles_count
  end
end
