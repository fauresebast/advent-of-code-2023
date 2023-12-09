module Day09
  def self.parse(input)
    input.lines.map{|line| line.split.map &:to_i}
  end

  def self.part1(input)
    sequences = parse(input)
    sequences.sum do |seq|
      history = []
      until seq.all?(&:zero?)
        history << seq
        seq = seq.each_cons(2).map {|a, b| b-a}
      end
      history.sum(&:last)
    end
  end

  def self.part2(input)
    sequences = parse(input)
    sequences.sum do |seq|
      history = []
      until seq.all?(&:zero?)
        history << seq
        seq = seq.each_cons(2).map {|a, b| b-a}
      end
      extrapolation = 0
      history.reverse_each {|h| extrapolation = h.first - extrapolation}
      extrapolation
    end
  end
end
