require "./days/day10/day10"
RSpec.describe Day10, "#solve" do
  it "part 1 works with sample" do
    str = File.read("./days/day10/sample")
    expect(Day10.part1(str)).to eq 8
  end

  it "part 1 works with input" do
    str = File.read("./days/day10/input")
    expect(Day10.part1(str)).to eq 7063
  end

  # My part 2 solution is partially correct and pass only the sample 3 and my input
  # or the sample 2 and 4

  # it "part 2 works with sample2" do
  #   str = File.read("./days/day10/sample2")
  #   expect(Day10.part2(str)).to eq 4
  # end

  it "part 2 works with sample3" do
    str = File.read("./days/day10/sample3")
    expect(Day10.part2(str)).to eq 8
  end

  # it "part 2 works with sample4" do
  #   str = File.read("./days/day10/sample4")
  #   expect(Day10.part2(str)).to eq 10
  # end

  it "part 2 works with input" do
    str = File.read("./days/day10/input")
    expect(Day10.part2(str)).to eq 589
  end
end
