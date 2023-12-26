require "./days/day25/day25"
RSpec.describe Day25, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day25/sample")
    expect(Day25.part1(str)).to eq 54
  end

  it "part 1 works with input" do
    str = File.read("./days/day25/input")
    expect(Day25.part1(str)).to eq nil
  end

  it "part 2 works with sample" do
    str = File.read("./days/day25/sample")
    expect(Day25.part2(str)).to eq nil
  end

  it "part 2 works with input" do
    str = File.read("./days/day25/input")
    expect(Day25.part2(str)).to eq nil
  end
end
