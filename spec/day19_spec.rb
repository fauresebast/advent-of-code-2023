require "./days/day19/day19"
RSpec.describe Day19, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day19/sample")
    expect(Day19.part1(str)).to eq 19114
  end

  it "part 1 works with input" do
    str = File.read("./days/day19/input")
    expect(Day19.part1(str)).to eq 420739
  end

  it "part 2 works with sample" do
    str = File.read("./days/day19/sample")
    expect(Day19.part2(str)).to eq 167409079868000
  end

  it "part 2 works with input" do
    str = File.read("./days/day19/input")
    expect(Day19.part2(str)).to eq nil
  end
end
