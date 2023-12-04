require "./days/day02/day02"
RSpec.describe Day02, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day02/sample")
    expect(Day02.part1(str)).to eq 8
  end

  it "part 1 works with input" do
    str = File.read("./days/day02/input")
    expect(Day02.part1(str)).to eq 1853
  end

  it "part 2 works with sample" do
    str = File.read("./days/day02/sample2")
    expect(Day02.part2(str)).to eq 2286
  end

  it "part 2 works with input" do
    str = File.read("./days/day02/input")
    expect(Day02.part2(str)).to eq 72706
  end
end
