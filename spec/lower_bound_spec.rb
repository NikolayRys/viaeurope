require_relative 'spec_helper'
require_relative '../lib/lower_bound'

describe BestFitDecreasing do

  test_data_table = []

  test_data_table << [[],
                      0]
  test_data_table << [[1],
                      1]
  test_data_table << [[6, 12, 15, 40, 43, 82],
                      2]
  test_data_table << [[99, 97, 94, 93, 8, 5, 4, 2],
                      5]
  test_data_table << [[100, 98, 96, 93, 91, 87, 81, 59, 58, 55, 50, 43, 22, 21, 20, 15, 14, 10, 8, 6, 5, 4, 3, 1, 0],
                      11]
  test_data_table << [[51, 48, 40, 26, 26, 9],
                      2] # Different between BFD and BC
  test_data_table << [[1262, 1227, 1049, 961, 945, 667, 650, 621, 567, 567, 564, 560, 536, 419, 312],
                      5]

  test_data_table.each do|values, bins|
    it "distributes set of #{values.size} values into bins" do
      expect(LowerBound.new(values, 100).get_min_bins).to eq(bins)
    end
  end
end
