require "./days/day17/day17"
RSpec.describe Day17, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day17/sample")
    expect(Day17.part1(str)).to eq 102
  end

  it "part 1 works with input" do
    str = File.read("./days/day17/input")
    expect(Day17.part1(str)).to eq nil
  end

  it "part 2 works with sample" do
    str = File.read("./days/day17/sample")
    expect(Day17.part2(str)).to eq nil
  end

  it "part 2 works with input" do
    str = File.read("./days/day17/input")
    expect(Day17.part2(str)).to eq nil
  end
end
