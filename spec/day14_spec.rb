require "./days/day14/day14"
RSpec.describe Day14, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day14/sample")
    expect(Day14.part1(str)).to eq 136
  end

  it "part 1 works with input" do
    str = File.read("./days/day14/input")
    expect(Day14.part1(str)).to eq 103333
  end

  it "part 2 works with sample" do
    str = File.read("./days/day14/sample")
    expect(Day14.part2(str)).to eq 64
  end

  it "part 2 works with input" do
    str = File.read("./days/day14/input")
    expect(Day14.part2(str)).to eq 97241
  end
end
