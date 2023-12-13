module Day13
  def self.parse(input)
    input.split("\n\n").map { |pattern| pattern.split("\n").map(&:chars) }
  end

  def self.biggest_pattern_size(pattern)
    i = 0
    while i < pattern.size - 1
      if pattern[i] == pattern[i + 1]
        a, b = i, i + 1
        (a -= 1
         b += 1) while a >= 0 && b < pattern.size && pattern[a] == pattern[b]
        return i + 1 if a < 0 || b >= pattern.size
      end
      i += 1
    end
    0
  end

  def self.part1(input)
    patterns = parse(input)
    patterns.sum do |pattern|
      biggest_pattern_size(pattern) * 100 + biggest_pattern_size(pattern.transpose)
    end
  end

  def self.biggest_pattern_size2(pattern)
    i = 0
    while i < pattern.size - 1
      a, b = i, i + 1
      diff = 0
      while a >= 0 && b < pattern.size
        diff += pattern[a].zip(pattern[b]).count { _1 != _2 }
        a -= 1
        b += 1
      end
      return i + 1 if (a < 0 || b >= pattern.size) && diff == 1
      i += 1
    end
    0
  end

  def self.part2(input)
    patterns = parse(input)
    patterns.sum do |pattern|
      biggest_pattern_size2(pattern) * 100 + biggest_pattern_size2(pattern.transpose)
    end
  end
end
