module Day03
  def self.parse(input)
    input.split("\n")
  end

  def self.part1(input)
    grid = parse(input)
    width = grid[0].size
    height = grid.size
    numbers = []
    acc = []
    keep_acc = false
    (0...height).each do |row|
      (0...width).each do |col|
        if grid[row][col][/^\d$/]
          acc << grid[row][col]
          (row - 1..row + 1).each do |r|
            (col - 1..col + 1).each do |c|
              next if r < 0 || c < 0 || r >= height || c >= width
              keep_acc ||= grid[r][c][/[^.0-9]/]
            end
          end
        else
          if keep_acc
            keep_acc = false
            numbers << acc.join.to_i
          end
          acc = []
        end
      end
    end
    numbers.sum
  end

  def self.part2(input)
    grid = parse(input)
    width = grid[0].size
    height = grid.size
    gears = {}
    acc = []
    keep_acc = nil
    (0...height).each do |row|
      (0...width).each do |col|
        if grid[row][col][/^\d$/]
          acc << grid[row][col]
          (row - 1..row + 1).each do |r|
            (col - 1..col + 1).each do |c|
              next if r < 0 || c < 0 || r >= height || c >= width
              keep_acc ||= [r, c] if grid[r][c]["*"]
            end
          end
        else
          if keep_acc
            gears[keep_acc] ||= []
            gears[keep_acc] << acc.join.to_i
            keep_acc = nil
          end
          acc = []
        end
      end
    end
    gears.filter { |_, n| n.size == 2 }.sum { |_, n| n[0] * n[1] }
  end
end
