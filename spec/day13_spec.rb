require "./days/day13/day13"
RSpec.describe Day13, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day13/sample")
    expect(Day13.part1(str)).to eq 405
  end

  it "part 1 works with input" do
    str = File.read("./days/day13/input")
    expect(Day13.part1(str)).to eq 30487
  end

  it "part 2 works with sample" do
    str = File.read("./days/day13/sample")
    expect(Day13.part2(str)).to eq 400
  end

  it "part 2 works with input" do
    str = File.read("./days/day13/input")
    expect(Day13.part2(str)).to eq 31954
  end
end
