module Day04
  def self.parse(input)
    cards = {}
    input.each_line do |line|
      card, series = line.split(": ")
      winning, numbers = series.split(" | ").map { |s| s.split.map(&:to_i) }
      cards[card[/\d+/].to_i] = [winning, numbers]
    end
    cards
  end

  def self.part1(input)
    cards = parse(input)
    cards.sum do |_, (winning, numbers)|
      common = winning & numbers
      common.size.zero? ? 0 : 2**(common.size - 1)
    end
  end

  def self.part2(input)
    cards = parse(input)
    q = cards.to_a
    sum = 0
    while q.any?
      id, (winning, numbers) = q.shift
      sum += 1
      common = winning & numbers
      (id + 1...id + 1 + common.size).each do |new_id|
        q << [new_id, cards[new_id]]
      end
    end
    sum
  end
end
