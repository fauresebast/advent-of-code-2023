require "./days/day12/day12"
RSpec.describe Day12, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day12/sample")
    expect(Day12.part1(str)).to eq 21
  end

  it "part 1 works with input" do
    str = File.read("./days/day12/input")
    expect(Day12.part1(str)).to eq 7017
  end

  it "part 2 works with sample" do
    str = File.read("./days/day12/sample")
    expect(Day12.part2(str)).to eq 525152
  end

  it "part 2 works with input" do
    str = File.read("./days/day12/input")
    expect(Day12.part2(str)).to eq nil
  end
end
