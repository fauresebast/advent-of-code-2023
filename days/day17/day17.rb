module Day17
  def self.parse(input)
    input.split("\n").map { |line| line.chars.map(&:to_i) }
  end

  def self.print_grid(width, height, path)
    (0...height).each do |r|
      line = ""
      (0...width).each do |c|
        line += path.include?([r, c]) ? "#" : "."
      end
      puts line
    end
  end

  def self.five_in_a_row(list)
    return false if list.size < 5
    rows, cols = list.last(5).reduce([[], []]) { |a, b| [a[0] << b[0], a[1] << b[1]] }
    rows.uniq.size == 1 || cols.uniq.size == 1
  end

  def self.part1(input)
    city = parse(input)
    width, height = city[0].size, city.size
    worst_value = width * height * 9 + 1
    dist = {}
    (0...height).each do |r|
      (0...width).each do |c|
        dist[[r, c]] = worst_value
      end
    end
    dist[[0, 0]] = 0
    seen = {}
    parents = {}
    parents[[0, 0]] = []
    while seen.size < dist.size
      (row, col), _ = dist.min_by { |k, v| seen[k] ? worst_value : v }
      seen[[row, col]] = true
      neighbours = [[0, 1], [0, -1], [1, 0], [-1, 0]].map do |drow, dcol|
        nrow, ncol = row + drow, col + dcol
        next if seen[[nrow, ncol]] || nrow < 0 || ncol < 0 || nrow >= width || ncol >= height || five_in_a_row(parents[[row, col]] + [[row, col], [nrow, ncol]])

        if dist[[nrow, ncol]].nil? || dist[[nrow, ncol]] > dist[[row, col]] + city[nrow][ncol]
          parents[[nrow, ncol]] = parents[[row, col]] + [[row, col]]
          dist[[nrow, ncol]] = dist[[row, col]] + city[nrow][ncol]
        end
      end
      dist[[row, col]] = worst_value if neighbours.compact.size.zero?
    end

    p path = parents[[height - 1, width - 1]]
    print_grid(width, height, path + [[height - 1, width - 1]])
    dist
  end

  def self.part2(input)
  end
end
