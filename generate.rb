require "date"

DATE_NUMBER = ARGV[0] || Date.today.day

# Assuming that the days/ and spec/ folders exists

# Creating new day folder
Dir.mkdir("days/day#{DATE_NUMBER}")

# Creating input and samples files
File.write("days/day#{DATE_NUMBER}/input", "")
File.write("days/day#{DATE_NUMBER}/sample", "")

# Writing .rb file
File.write("days/day#{DATE_NUMBER}/day#{DATE_NUMBER}.rb", "module Day#{DATE_NUMBER}
  def self.parse(input)
  end

  def self.part1(input)
  end

  def self.part2(input)
  end
end
")

# Writing spec file
File.write("spec/day#{DATE_NUMBER}_spec.rb", "require \"./days/day#{DATE_NUMBER}/day#{DATE_NUMBER}\"
RSpec.describe Day#{DATE_NUMBER}, \"#solve\" do
  it \"part 1 works with sample\" do
    str = File.read(\"./days/day#{DATE_NUMBER}/sample\")
    expect(Day#{DATE_NUMBER}.part1(str)).to eq nil
  end

  it \"part 1 works with input\" do
    str = File.read(\"./days/day#{DATE_NUMBER}/input\")
    expect(Day#{DATE_NUMBER}.part1(str)).to eq nil
  end

  it \"part 2 works with sample\" do
    str = File.read(\"./days/day#{DATE_NUMBER}/sample\")
    expect(Day#{DATE_NUMBER}.part2(str)).to eq nil
  end

  it \"part 2 works with input\" do
    str = File.read(\"./days/day#{DATE_NUMBER}/input\")
    expect(Day#{DATE_NUMBER}.part2(str)).to eq nil
  end
end
")
