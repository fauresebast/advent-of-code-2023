require "./days/day04/day04"
RSpec.describe Day04, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day04/sample")
    expect(Day04.part1(str)).to eq 13
  end

  it "part 1 works with input" do
    str = File.read("./days/day04/input")
    expect(Day04.part1(str)).to eq 25010
  end

  it "part 2 works with sample" do
    str = File.read("./days/day04/sample")
    expect(Day04.part2(str)).to eq 30
  end

  it "part 2 works with input" do
    str = File.read("./days/day04/input")
    expect(Day04.part2(str)).to eq 9924412
  end
end
