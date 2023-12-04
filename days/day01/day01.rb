module Day01
  def self.parse(input)
    input.split("\n")
  end

  def self.part1(input)
    parse(input).sum { |line|
      digits = line.scan(/\d/)
      [digits.first, digits.last].join.to_i
    }
  end

  def self.part2(input)
    str_to_digits = {"one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6,
                     "seven" => 7, "eight" => 8, "nine" => 9}
    parse(input).sum do |line|
      first = line[/(#{["\\d", *str_to_digits.keys].join("|")})/]
      first = str_to_digits[first] unless first[/\d/]
      last = line.reverse[/(#{["\\d", *str_to_digits.keys.map(&:reverse)].join("|")})/]
      last = str_to_digits[last.reverse] unless last[/\d/]
      [first, last].join.to_i
    end
  end
end
