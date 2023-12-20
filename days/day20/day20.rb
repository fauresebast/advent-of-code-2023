module Day20
  class Module
    attr_reader :id, :type, :destinations

    def initialize(id, type_char, destinations)
      @id = id
      @type_char = type_char
      @type = type_char == "" ? :broadcaster : (type_char == "%" ? :flipflop : :conjunction)
      @destinations = destinations
    end

    def broadcaster?
      @type == :broadcaster
    end

    def flipflop?
      @type == :flipflop
    end

    def conjunction?
      @type == :conjunction
    end

    def to_s
      "#{@type_char}#{@id} -> #{@destinations.join(",")}"
    end
  end

  class FlipFlop < Module
    attr_reader :status

    def initialize(id, type_char, destinations)
      super(id, type_char, destinations)
      @status = :off
    end

    def flip!
      @status = @status == :off ? :on : :off
    end
  end

  class Conjunction < Module
    attr_reader :memory

    def initialize(id, type_char, destinations)
      super(id, type_char, destinations)
      @memory = {}
    end

    def set_memory(id, value)
      @memory[id] = value
    end

    def get_signal
      @memory.values.all?{ _1 == :high } ? :low : :high
    end
  end

  def self.parse(input)
    modules = input.split("\n").to_h do |line|
      if line[0] == "%"
        id = line[/(?<=%)[a-z]+/]
        [id, FlipFlop.new(id, line[0], line.split("->").last.split(",").map(&:strip))]
      elsif line[0] == "&"
        id = line[/(?<=&)[a-z]+/]
        [id, Conjunction.new(id, line[0], line.split("->").last.split(",").map(&:strip))]
      else
        id = line[/^[a-z]+/]
        [id, Module.new(id, "", line.split("->").last.split(",").map(&:strip))]
      end
    end

    modules.each do |mod_id, mod|
      mod.destinations.each do |dest_id|
        dest = modules[dest_id]
        dest.memory[mod_id] = :low if dest&.conjunction?
      end
    end
    modules
  end

  def self.part1(input)
    modules = parse(input)
    low_pulses, high_pulses = 0, 0
    1000.times do
      queue = [[:low, "button", "broadcaster"]]
      # p "=="
      while queue.any?
        pulse, sender, module_id = queue.shift
        # puts "#{sender} -#{pulse}-> #{module_id}"
        current = modules[module_id]
        pulse == :low ? (low_pulses += 1) : (high_pulses += 1)
        next if current.nil?

        if current.broadcaster?
          current.destinations.each { |dest| queue << [pulse, current.id, dest] }
        elsif current.flipflop?
          if pulse == :low
            current.flip!
            current.destinations.each { |dest| queue << [current.status == :on ? :high : :low, current.id, dest] }
          end
        elsif current.conjunction?
          current.set_memory(sender, pulse)
          signal = current.get_signal
          current.destinations.each { |dest| queue << [signal, current.id, dest] }
        else
          raise UnknownModuleType
        end
      end
    end
    low_pulses * high_pulses
  end

  def self.part2(input)
    modules = parse(input)
    conjunctions = modules.filter{|k, m| m.conjunction? }.map(&:last)
    button_pressed = 0
    mem = {}
    loop do
      queue = [[:low, "button", "broadcaster"]]
      button_pressed += 1
      p [button_pressed, mem.size, modules["zh"].memory] if button_pressed % 100_000 == 0
      while queue.any?
        pulse, sender, module_id = queue.shift

        # puts "#{sender} -#{pulse}-> #{module_id}"
        current = modules[module_id]
        next if current.nil?

        cur_key = [pulse, sender, module_id, conjunctions.map(&:memory).to_s]
        next if mem[cur_key]
        mem[cur_key] = true

        if current.broadcaster?
          current.destinations.each { |dest| queue << [pulse, current.id, dest] }
        elsif current.flipflop?
          if pulse == :low
            current.flip!
            current.destinations.each do |dest|
              new_pulse = current.status == :on ? :high : :low
              return button_pressed if new_pulse == :low && dest == "rx"
              queue << [new_pulse, current.id, dest]
            end
          end
        elsif current.conjunction?
          current.set_memory(sender, pulse)
          signal = current.get_signal
          current.destinations.each do |dest|
            return button_pressed if signal == :low && dest == "rx"
            queue << [signal, current.id, dest]
          end
        else
          raise UnknownModuleType
        end
      end
    end
    button_pressed
  end
end
