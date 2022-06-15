require_relative 'spec_helper'
require_relative '../lib/lower_bound'

describe LowerBound do

  test_data_table = []

  test_data_table << [[],
                      0, 5]
  test_data_table << [[1],
                      1, 5]
  test_data_table << [[6, 12, 15, 40, 43, 82],
                      2, 100]
  test_data_table << [[99, 97, 94, 93, 8, 5, 4, 2],
                      5, 100]
  test_data_table << [[100, 98, 96, 93, 91, 87, 81, 59, 58, 55, 50, 43, 22, 21, 20, 15, 14, 10, 8, 6, 5, 4, 3, 1, 0],
                      11, 100]
  test_data_table << [[51, 48, 40, 26, 26, 9],
                      2, 100] # Different between BFD and BC
  test_data_table << [[1262, 1227, 1049, 961, 945, 667, 650, 621, 567, 567, 564, 560, 536, 419, 312],
                      5, 2311]

  test_data_table.each do |values, bins, size|
    it "distributes set of #{values.size} values into bins of size #{size}" do
      expect(LowerBound.new(values, size).get_min_bins).to eq(bins)
    end
  end
end
