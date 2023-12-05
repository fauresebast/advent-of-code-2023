require "./days/day05/day05"
RSpec.describe Day05, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day05/sample")
    expect(Day05.part1(str)).to eq 35
  end

  it "part 1 works with input" do
    str = File.read("./days/day05/input")
    expect(Day05.part1(str)).to eq 525792406
  end

  it "part 2 works with sample" do
    str = File.read("./days/day05/sample2")
    expect(Day05.part2(str)).to eq 46
  end

  it "part 2 works with input" do
    str = File.read("./days/day05/input")
    expect(Day05.part2(str)).to eq 79004094
  end
end
