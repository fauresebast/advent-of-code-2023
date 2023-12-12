module Day12
  def self.parse(input)
    input.lines.map do |input_row|
      row, damaged_str = input_row.split
      damaged_groups = damaged_str.split(',').map(&:to_i)
      [row, damaged_groups]
    end
  end

  def self.match(row, damaged_groups)
    row.scan(/#+/).map(&:size) == damaged_groups ? 1 : 0
  end

  def self.count(row, damaged_groups, missing_damaged)
    return match(row.tr("?", "."), damaged_groups) if missing_damaged.zero?
    return match(row.tr("?", "#"), damaged_groups) if row.count("?") == missing_damaged

    i = row.index("?")
    [".", "#"].sum do |c|
      row[i] = c
      k = i
      k += 1 while k < row.size-1 && row[k] != "."
      scan = row[..k].scan(/#+[#?]*/).map(&:size).reject(&:zero?)
      if scan.zip(damaged_groups[0...scan.size]).all? { _1 >= _2}
        count(row.dup, damaged_groups, missing_damaged - (c == "#" ? 1 : 0))
      else
        0
      end
    end
  end

  def self.part1(input)
    parse(input).sum do |row, damaged_groups|
      missing_damaged = damaged_groups.sum - row.count("#")
      count(row, damaged_groups, missing_damaged)
    end
  end

  def self.part2(input)
    i = 0
    parse(input).sum do |row, damaged_groups|
      row = ((row + "?") * 5).chop
      damaged_groups = damaged_groups * 5
      missing_damaged = damaged_groups.sum - row.count("#")
      c = count(row, damaged_groups, missing_damaged)
      p [i+=1, c]
      c
    end
  end
end