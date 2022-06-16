require_relative '../spec_helper'
require_relative '../../lib/algos/brute_force'

describe BruteForce do

  test_data_table = []

  test_data_table << [[],
                      [],
                      5]
  test_data_table << [[1],
                      [[1]],
                      5]
  test_data_table << [[6, 12, 15, 40, 43, 82],
                      [[82, 12, 6], [43, 40, 15]],
                      100]
  test_data_table << [[99, 97, 94, 93, 8, 5, 4, 2],
                      [[8, 2], [93, 4], [94, 5], [97], [99]],
                      100]
  test_data_table << [[51, 48, 40, 26, 26, 9],
                      [[40, 26, 9], [51, 48]], # BC can find optimal solution for this case
                      100]
  test_data_table << [[1262, 1227, 1049, 961, 945, 667, 650, 621, 567, 567, 564, 560, 536, 419, 312],
                      [[945, 312], [1227, 560, 419], [621, 567, 564, 536], [961, 667, 650], [1262, 1049]],
                      2311]

  test_data_table.each do|values, bins, size|
    it "distributes set of #{values.size} values into bins of #{size}" do
      expect(BruteForce.new(values, bins.size, 5, size).distribute!).to eq(bins)
    end
  end

  it 'stops if time limit is reached' do
    values = [100, 98, 96, 93, 91, 87, 81, 59, 58, 55, 50, 43, 22, 21, 20, 15, 14, 10, 8, 6, 5, 4, 3, 1, 0]
    expect{BruteForce.new(values, 11, 1, 100).distribute!}.to raise_error(RuntimeError, 'Time limit reached')
  end
end
