require "./days/day03/day03"
RSpec.describe Day03, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day03/sample")
    expect(Day03.part1(str)).to eq 4361
  end

  it "part 1 works with input" do
    str = File.read("./days/day03/input")
    expect(Day03.part1(str)).to eq 517021
  end

  it "part 2 works with sample" do
    str = File.read("./days/day03/sample2")
    expect(Day03.part2(str)).to eq 467835
  end

  it "part 2 works with input" do
    str = File.read("./days/day03/input")
    expect(Day03.part2(str)).to eq 81296995
  end
end
