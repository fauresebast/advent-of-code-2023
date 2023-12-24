module Day23
  def self.parse(input)
    moutain = input.split("\n")
    start = [0, moutain[0].index(".")]
    goal = [moutain.size - 1, moutain[-1].index(".")]
    [moutain, start, goal]
  end

  def self.print(moutain, current, parents)
    height, width = moutain.size, moutain[0].size
    (0...height).each do |r|
      line = ""
      (0...width).each do |w|
        line += if parents[current]&.include?([r, w]) || current == [r, w]
          "O"
        else
          moutain[r][w]
        end
      end
      puts line
    end
  end

  def self.part1(input)
    moutain, start, goal = parse(input)
    height, width = moutain.size, moutain[0].size
    dist = {}
    parents = {}
    dist[start] = [1]
    parents[start] = []
    queue = [start]
    while queue.any?
      current = queue.shift
      current_neigh_dist = dist[current].max + 1
      [[1, 0], [0, 1], [-1, 0], [0, -1]].each do |drow, dcol|
        nrow, ncol = current[0] + drow, current[1] + dcol
        next if nrow < 0 || ncol < 0 || nrow >= height || ncol >= width || moutain[nrow][ncol] == "#"
        next if (moutain[nrow][ncol] == "v" && drow < 0) || (moutain[nrow][ncol] == ">" && dcol < 0) || (moutain[nrow][ncol] == "<" && dcol > 0)

        dist[[nrow, ncol]] ||= []
        dist[[nrow, ncol]] << current_neigh_dist
        queue << [nrow, ncol] if parents[[nrow, ncol]].nil?
        parents[[nrow, ncol]] = parents[current] + [current]
      end
      queue.uniq!
      queue.sort_by! { |pos| - dist[pos].max }
    end
    # puts "=" * (width/2-2) + " END " + "=" * (width/2-2)
    # print(moutain, goal, parents)
    dist[goal]
  end

  def self.part2(input)
  end
end
