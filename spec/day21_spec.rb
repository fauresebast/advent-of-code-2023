require "./days/day21/day21"
RSpec.describe Day21, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day21/sample")
    expect(Day21.part1(str)).to eq 42
  end

  it "part 1 works with input" do
    str = File.read("./days/day21/input")
    expect(Day21.part1(str)).to eq 3841
  end

  it "part 2 works with sample" do
    str = File.read("./days/day21/sample")
    expect(Day21.part2(str)).to eq nil
  end

  it "part 2 works with input" do
    str = File.read("./days/day21/input")
    expect(Day21.part2(str)).to eq nil
  end
end
