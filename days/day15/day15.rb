module Day15
  def self.parse(input)
    input.split(",")
  end

  def self.hash(step)
    current_value = 0
    step.chars.each do |c|
      current_value += c.ord
      current_value *= 17
      current_value %= 256
    end
    current_value
  end

  def self.part1(input)
    parse(input).sum do |step|
      hash(step)
    end
  end

  def self.part2(input)
    boxes = {}
    parse(input).each do |step|
      if step[/=/]
        label, focal_length = step.split("=")
        box_id = hash(label)
        boxes[box_id] ||= []
        if boxes[box_id].find { |l, _| l == label }
          boxes[box_id] = boxes[box_id].map { |b| (b[0] == label) ? [label, focal_length.to_i] : b }
        else
          boxes[box_id] << [label, focal_length.to_i]
        end
      else
        label = step.delete("-")
        box_id = hash(label)
        boxes[box_id]&.reject! { |l, _| l == label }
      end
    end
    boxes.sum do |k, lenses|
      lenses.map.with_index(1) do |(_, focal_length), index|
        (k + 1) * index * focal_length
      end.sum
    end
  end
end
