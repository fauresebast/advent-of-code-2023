require "./days/day20/day20"
RSpec.describe Day20, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day20/sample")
    expect(Day20.part1(str)).to eq 32000000
  end

  it "part 1 works with sample2" do
    str = File.read("./days/day20/sample2")
    expect(Day20.part1(str)).to eq 11687500
  end

  it "part 1 works with input" do
    str = File.read("./days/day20/input")
    expect(Day20.part1(str)).to eq 777666211
  end

  it "part 2 works with sample" do
    str = File.read("./days/day20/sample2")
    expect(Day20.part2(str)).to eq 1
  end

  it "part 2 works with input" do
    str = File.read("./days/day20/input")
    expect(Day20.part2(str)).to eq nil
  end
end
