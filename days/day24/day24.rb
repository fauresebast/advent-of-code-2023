module Day24
  def self.parse(input)
    input.split("\n").map do |line|
      line.scan(/-?\d+/).map(&:to_f)
    end
  end

  def self.intersect(a, b)
    x_1, y_1, _, v_x1, v_y1, _ = a
    x_2, y_2, _, v_x2, v_y2, _ = b

    m_1 = v_y1 / v_x1
    m_2 = v_y2 / v_x2

    return [nil, nil] if (m_1 / m_2).abs == 1

    b_1 = y_1 - m_1 * x_1
    b_2 = y_2 - m_2 * x_2

    x = (b_2 - b_1) / (m_1 - m_2)
    y = m_1 * x + b_1

    t_1 = (x - x_1) / v_x1
    t_2 = (x - x_2) / v_x2

    return [nil, nil] if t_1 < 0 || t_2 < 0

    [x, y]
  end

  def self.part1(input, area_start, area_end)
    parse(input).combination(2).count do |a, b|
      x, y = intersect(a, b)
      (x.nil? || y.nil?) ? false : x >= area_start && x <= area_end && y >= area_start && y <= area_end
    end
  end

  def self.part2(input)
  end
end
