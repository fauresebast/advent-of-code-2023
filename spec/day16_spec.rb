require "./days/day16/day16"
RSpec.describe Day16, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day16/sample")
    expect(Day16.part1(str)).to eq 46
  end

  it "part 1 works with input" do
    str = File.read("./days/day16/input")
    expect(Day16.part1(str)).to eq 7608
  end

  it "part 2 works with sample" do
    str = File.read("./days/day16/sample")
    expect(Day16.part2(str)).to eq 51
  end

  it "part 2 works with input" do
    str = File.read("./days/day16/input")
    expect(Day16.part2(str)).to eq 8221
  end
end
