require './days/day06/day06'
RSpec.describe Day06, '#solve' do
  it 'part 1 works with sample' do
    str = File.open('./days/day06/sample').read
    expect(Day06.part1(str)).to eq 288
  end

  it 'part 1 works with input' do
    str = File.open('./days/day06/input').read
    expect(Day06.part1(str)).to eq 252000
  end

  it 'part 2 works with sample' do
    str = File.open('./days/day06/sample').read
    expect(Day06.part2(str)).to eq 71503
  end

  it 'part 2 works with input' do
    str = File.open('./days/day06/input').read
    expect(Day06.part2(str)).to eq 36992486
  end
end
