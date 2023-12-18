module Day16
  def self.parse(input)
    input.split("\n")
  end

  class Beam
    attr_reader :pos, :direction

    def initialize(pos, direction)
      @pos = pos
      @direction = direction
    end

    def to_s
      "Beam(#{@pos}, #{@direction})"
    end

    def continue!
      case @direction
      when :right
        @pos = [@pos[0], @pos[1] + 1]
      when :left
        @pos = [@pos[0], @pos[1] - 1]
      when :up
        @pos = [@pos[0] - 1, @pos[1]]
      when :down
        @pos = [@pos[0] + 1, @pos[1]]
      else
        puts "UnknownDirection: direction value:"
        p direction
        raise UnknownDirection
      end
    end

    def reflect!(mirror)
      matching_direction = if mirror == "/"
        {up: :right, left: :down, right: :up, down: :left}
      elsif mirror == "\\"
        {up: :left, right: :down, left: :up, down: :right}
      else
        puts "UnknownMirror: mirror value:"
        p mirror
        raise UnknownMirror
      end
      @direction = matching_direction[@direction]
      continue!
    end
  end

  def self.print_grid(grid, energized_tiles = {})
    height, width = grid.size, grid[0].size
    (0...height).each do |row|
      line = ""
      (0...width).each do |col|
        line += (energized_tiles[[row, col]] > 0) ? "#" : grid[row][col]
      end
      puts line
    end
  end

  def self.run_beam(grid, beam)
    height, width = grid.size, grid[0].size
    obstacles = {}
    energized_tiles = Hash.new(0)
    beams = [beam]
    while beams.any?
      beam = beams.shift
      row, col = beam.pos
      if row >= 0 && row < height && col >= 0 && col < width
        energized_tiles[beam.pos] += 1
        next if obstacles[[row, col]]&.include?(beam.direction)
        if grid[row][col] != "."
          obstacles[[row, col]] ||= []
          obstacles[[row, col]] << beam.direction
        end
        if grid[row][col] == "." ||
            (grid[row][col] == "-" && [:left, :right].include?(beam.direction)) ||
            (grid[row][col] == "|" && [:up, :down].include?(beam.direction))
          beam.continue!
          beams << beam
        else
          case grid[row][col]
          when "|"
            beams << Beam.new([row - 1, col], :up)
            beams << Beam.new([row + 1, col], :down)
          when "-"
            beams << Beam.new([row, col - 1], :left)
            beams << Beam.new([row, col + 1], :right)
          else # "/" or "\"
            beam.reflect!(grid[row][col])
            beams << beam
          end
        end
      end
    end
    energized_tiles.size
  end

  def self.part1(input)
    grid = parse(input)
    run_beam(grid, Beam.new([0, 0], :right))
  end

  def self.part2(input)
    grid = parse(input)
    best_beam_score = 0
    height, width = grid.size, grid[0].size
    # form top edge
    best_beam_score = [best_beam_score, (0...width).map { |c| run_beam(grid, Beam.new([0, c], :down)) }.max].max
    # from bottom edge
    best_beam_score = [best_beam_score, (0...width).map { |c| run_beam(grid, Beam.new([height - 1, c], :up)) }.max].max
    # from left edge
    best_beam_score = [best_beam_score, (0...height).map { |r| run_beam(grid, Beam.new([r, 0], :right)) }.max].max
    # from right edge
    [best_beam_score, (0...height).map { |r| run_beam(grid, Beam.new([r, width - 1], :left)) }.max].max
  end
end
