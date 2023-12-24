module Day21
  def self.parse(input)
    garden = input.split("\n")
    start = []
    garden.each_with_index do |line, row_index|
      if (col_index = line.index("S"))
        start = [row_index, col_index]
        break
      end
    end
    [garden, start]
  end

  def self.part1(input)
    garden, start = parse(input)
    width, height = garden[0].size, garden.size
    queue = [start]
    64.times do
      next_queue = []
      queue.each do |pos|
        row, col = pos
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |drow, dcol|
          next if row + drow < 0 || row + drow >= height || col + dcol < 0 || col + dcol >= width || garden[row + drow][col + dcol] == "#"
          next_queue << [row + drow, col + dcol]
        end
      end
      queue = next_queue.uniq
    end
    queue.size
  end

  def self.part2(input)
    # memoization
  end
end
