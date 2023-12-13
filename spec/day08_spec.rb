require "./days/day08/day08"
RSpec.describe Day08, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day08/sample")
    expect(Day08.part1(str)).to eq 2
  end

  it "part 1 works with sample2" do
    str = File.read("./days/day08/sample2")
    expect(Day08.part1(str)).to eq 6
  end

  it "part 1 works with input" do
    str = File.read("./days/day08/input")
    expect(Day08.part1(str)).to eq 13939
  end

  it "part 2 works with sample" do
    str = File.read("./days/day08/sample_part2")
    expect(Day08.part2(str)).to eq 6
  end

  it "part 2 works with input" do
    str = File.read("./days/day08/input")
    expect(Day08.part2(str)).to eq 8906539031197
  end
end
