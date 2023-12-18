module Day18
  def self.parse(input)
    input.split("\n").map { |line|
      direction, length, color = line.split
      {direction:, length: length.to_i, color: color.tr("()", "")}
    }
  end

  def self.print_grid(trenches)
    min_height, max_height = trenches.keys.map(&:first).minmax
    min_width, max_width = trenches.keys.map(&:last).minmax
    (min_height..max_height).each do |r|
      line = ""
      (min_width..max_width).each do |c|
        line += trenches[[r, c]] ? "#" : "."
      end
      puts line
    end
  end

  def self.part1(input)
    plan = parse(input)
    current = [0, 0]
    trenches = {}
    plan.each do |trench|
      case trench[:direction]
      when "R"
        (0...trench[:length]).each { |k| trenches[[current[0], current[1] + k]] = true }
        current[1] += trench[:length]
      when "L"
        (0...trench[:length]).each { |k| trenches[[current[0], current[1] - k]] = true }
        current[1] -= trench[:length]
      when "U"
        (0...trench[:length]).each { |k| trenches[[current[0] - k, current[1]]] = true }
        current[0] -= trench[:length]
      when "D"
        (0...trench[:length]).each { |k| trenches[[current[0] + k, current[1]]] = true }
        current[0] += trench[:length]
      else
        p direction
        raise UnknownDirection
      end
    end
    min_height, max_height = trenches.keys.map(&:first).minmax
    floodstart = nil
    (min_height..max_height).each do |r|
      t = trenches.keys.filter { |a, _| a == r }
      if t.size == 2
        floodstart = [t.min[0], t.min[1] + 1]
        break
      end
    end
    queue = [floodstart]
    while queue.any?
      current = queue.shift
      next if trenches[current]
      trenches[current] = true
      [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dx, dy|
        n = [current[0] + dx, current[1] + dy]
        queue << n
      end
    end
    trenches.size
  end

  def self.part2(input)
    direction_mapping = %w[R D L U]
    plan = parse(input)
    current = [0, 0]
    perimeter = 0
    edges = plan.map! do |p|
      color = p[:color].delete("#")
      direction = direction_mapping[color[-1].to_i]
      length = color[...5].hex
      perimeter += length
      end_point = case direction
      when "R"
        [current[0], current[1] + length]
      when "L"
        [current[0], current[1] - length]
      when "U"
        [current[0] - length, current[1]]
      when "D"
        [current[0] + length, current[1]]
      else
        p direction
        raise UnknownDirection
      end
      edge = {x1: current[0], y1: current[1], x2: end_point[0], y2: end_point[1]}
      current = end_point
      edge
    end
    edges.sum do |edge|
      (edge[:x1] * edge[:y2] - edge[:x2] * edge[:y1]) / 2.0
    end.abs + perimeter / 2.0 + 1
  end
end
