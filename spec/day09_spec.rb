require "./days/day09/day09"
RSpec.describe Day09, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day09/sample")
    expect(Day09.part1(str)).to eq 114
  end

  it "part 1 works with input" do
    str = File.read("./days/day09/input")
    expect(Day09.part1(str)).to eq 1938731307
  end

  it "part 2 works with sample" do
    str = File.read("./days/day09/sample")
    expect(Day09.part2(str)).to eq 2
  end

  it "part 2 works with input" do
    str = File.read("./days/day09/input")
    expect(Day09.part2(str)).to eq 948
  end
end
