module Day08
  def self.parse(input)
    lines = input.lines
    [
      lines[0].chomp,
      lines[2..].map{|line| k, l, r = line.scan(/[A-Z]{3}/); [k, {"L" => l, "R" => r}]}.to_h
    ]
  end

  def self.part1(input)
    instructions, nodes = parse(input)
    index = 0
    step = 0
    current = "AAA"
    while current != "ZZZ"
      instruction = instructions[index]
      current = nodes[current][instruction]
      step += 1
      index = (index + 1) % instructions.size
    end
    step
  end

  def self.part2(input)
    instructions, nodes = parse(input)
    ghosts = nodes.keys.filter{|k| k[-1] == "A"}
    path_size = ghosts.map do |current|
      index = 0
      step = 0
      while current[-1] != "Z"
        instruction = instructions[index]
        current = nodes[current][instruction]
        step += 1
        index = (index + 1) % instructions.size
      end
      step
    end
    path_size.reduce(1, :lcm)
  end
end
