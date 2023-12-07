require "./days/day07/day07"
RSpec.describe Day07, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day07/sample")
    expect(Day07.part1(str)).to eq 6440
  end

  it "part 1 works with input" do
    str = File.read("./days/day07/input")
    expect(Day07.part1(str)).to eq 246912307
  end

  it "part 2 works with sample" do
    str = File.read("./days/day07/sample")
    expect(Day07.part2(str)).to eq 5905
  end

  it "part 2 works with input" do
    str = File.read("./days/day07/input")
    expect(Day07.part2(str)).to eq 246894760
  end
end
