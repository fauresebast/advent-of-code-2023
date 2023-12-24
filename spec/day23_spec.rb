require "./days/day23/day23"
RSpec.describe Day23, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day23/sample")
    expect(Day23.part1(str)).to eq 94
  end

  it "part 1 works with input" do
    str = File.read("./days/day23/input")
    expect(Day23.part1(str)).to eq nil
  end

  it "part 2 works with sample" do
    str = File.read("./days/day23/sample")
    expect(Day23.part2(str)).to eq nil
  end

  it "part 2 works with input" do
    str = File.read("./days/day23/input")
    expect(Day23.part2(str)).to eq nil
  end
end
