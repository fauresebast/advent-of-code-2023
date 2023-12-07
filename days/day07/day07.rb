module Day07
  def self.parse(input)
    input.lines.map do |line|
      hand, bid = line.split
      {hand: hand.chars, bid: bid.to_i}
    end
  end

  def self.part1(input)
    cards = %w[2 3 4 5 6 7 8 9 T J Q K A]
    hands = parse(input)
    order_hands(hands, cards)
  end

  def self.part2(input)
    cards = %w[J 2 3 4 5 6 7 8 9 T Q K A]

    hands = parse(input)
    order_hands(hands, cards, j_as_joker=true)
  end

  def self.order_hands(hands, cards, j_as_joker=false)
    hands.sort! do |a, b|
      type_diff = hand_type(a[:hand], cards, j_as_joker) <=> hand_type(b[:hand], cards, j_as_joker)
      if type_diff.zero?
        i = 0
        i += 1 while a[:hand][i] == b[:hand][i]
        type_diff = cards.index(a[:hand][i]) <=> cards.index(b[:hand][i])
      end
      type_diff
    end
    hands.map.with_index(1) {|h, i| h[:bid] * i}.sum
  end

  def self.hand_type(hand, cards, j_as_joker)
    if j_as_joker && hand.include?("J")
      count = hand.reject{|c| c == "J"}.tally
      max_count = count.values.max
      best_card, _ = count.to_a.filter{|_, v| v == max_count}.max_by{|c, _| cards.index(c)}
      hand = hand.map {|c| c == "J" ? best_card : c}
    end

    return 7 if hand.uniq.size == 1 # Five of a kind

    count = hand.tally
    return 6 if count.values.max == 4 # Four of a kind
    return 5 if count.values.sort == [2, 3] # Fullhouse
    return 4 if count.values.max == 3 # Three of a kind
    return 3 if count.values.sort == [1, 2, 2] # Two pairs
    return 2 if count.values.max == 2 # One pair
    return 1 # Highest card
  end
end
