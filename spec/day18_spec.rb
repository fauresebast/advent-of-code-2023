require "./days/day18/day18"
RSpec.describe Day18, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day18/sample")
    expect(Day18.part1(str)).to eq 62
  end

  it "part 1 works with input" do
    str = File.read("./days/day18/input")
    expect(Day18.part1(str)).to eq 31171
  end

  it "part 2 works with sample" do
    str = File.read("./days/day18/sample")
    expect(Day18.part2(str)).to eq 952408144115
  end

  it "part 2 works with input" do
    str = File.read("./days/day18/input")
    expect(Day18.part2(str)).to eq 131431655002266
  end
end
