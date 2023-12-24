require "./days/day22/day22"
RSpec.describe Day22, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day22/sample")
    expect(Day22.part1(str)).to eq 5
  end

  it "part 1 works with input" do
    str = File.read("./days/day22/input")
    expect(Day22.part1(str)).to eq nil
  end

  it "part 2 works with sample" do
    str = File.read("./days/day22/sample")
    expect(Day22.part2(str)).to eq nil
  end

  it "part 2 works with input" do
    str = File.read("./days/day22/input")
    expect(Day22.part2(str)).to eq nil
  end
end
