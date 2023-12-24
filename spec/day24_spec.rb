require "./days/day24/day24"
RSpec.describe Day24, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day24/sample")
    expect(Day24.part1(str, 7, 27)).to eq 2
  end

  it "part 1 works with input" do
    str = File.read("./days/day24/input")
    expect(Day24.part1(str, 200000000000000, 400000000000000)).to eq nil
  end

  it "part 2 works with sample" do
    str = File.read("./days/day24/sample")
    expect(Day24.part2(str)).to eq 47
  end

  it "part 2 works with input" do
    str = File.read("./days/day24/input")
    expect(Day24.part2(str)).to eq nil
  end
end
