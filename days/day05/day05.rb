require "active_support/all"

module Day05
  def self.parse(input)
    {
      seeds: input[/^.*\n/].scan(/\d+/).map(&:to_i),
      convertions: input.split("map:")[1..].map do |m|
        m.scan(/\d+/).map(&:to_i).each_slice(3).map { {destination_start: _1, source_start: _2, range: _3} }
      end
    }
  end

  def self.part1(input)
    data = parse(input)
    data[:seeds].map do |seed|
      data[:convertions].each do |convertion|
        convertion.each do |range|
          if range[:source_start] <= seed && seed < range[:source_start] + range[:range]
            seed = range[:destination_start] + (seed - range[:source_start])
            break
          end
        end
      end
      seed
    end.min
  end

  def self.part2(input)
    data = parse(input)
    seeds = data[:seeds].each_slice(2).map { {start: _1, range: _2} }
    data[:convertions].each do |convertion|
      new_seeds = []
      while seeds.any?
        seed = seeds.shift
        nothing_applied = true
        convertion.each do |range|
          if (range[:source_start]...range[:source_start] + range[:range]).overlaps?(seed[:start]...seed[:start] + seed[:range])
            nothing_applied = false
            # seed is included in convertion's range
            if range[:source_start] <= seed[:start] && seed[:start] + seed[:range] <= range[:source_start] + range[:range]
              new_seeds << {start: range[:destination_start] + (seed[:start] - range[:source_start]), range: seed[:range]}
            # seed overlaps because seed's start is below convertion's range
            elsif range[:source_start] > seed[:start] && seed[:start] + seed[:range] <= range[:source_start] + range[:range]
              new_range = seed[:start] + seed[:range] - range[:source_start]
              new_seeds << {start: range[:destination_start], range: new_range}
              seeds << {start: seed[:start], range: seed[:range] - new_range}
            # seed overlaps because seed's end is above convertion's range
            elsif range[:source_start] <= seed[:start] && seed[:start] + seed[:range] > range[:source_start] + range[:range]
              new_range = range[:source_start] + range[:range] - seed[:start]
              new_seeds << {start: range[:destination_start] + (seed[:start] - range[:source_start]), range: new_range}
              seeds << {start: range[:source_start] + range[:range], range: seed[:range] - new_range}
            # seed include convertion's range
            elsif range[:source_start] > seed[:start] && seed[:start] + seed[:range] > range[:source_start] + range[:range]
              new_seeds << {start: range[:destination_start], range: range[:range]}
              seeds << {start: seed[:start], range: range[:source_start] - seed[:start]}
              seeds << {start: range[:source_start] + range[:range], range: (seed[:start] + seed[:range]) - (range[:source_start] + range[:range])}
            end
          end
        end
        new_seeds << seed if nothing_applied
      end
      seeds = new_seeds.uniq
    end
    seeds.map { |s| s[:start] }.min
  end
end
