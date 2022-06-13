require_relative 'spec_helper'
require_relative '../../lib/algos/best_fit_decreasing'

describe BestFitDecreasing do

  test_data_table = []

  test_data_table << [[],
                      []]
  test_data_table << [[1],
                      [[1]]]
  test_data_table << [[6, 12, 15, 40, 43, 82],
                      [[82, 12, 6], [43, 40, 15]]]
  test_data_table << [[99, 97, 94, 93, 8, 5, 4, 2],
                      [[93, 4, 2], [94, 5], [99], [97], [8]]]
  test_data_table << [[100, 98, 96, 93, 91, 87, 81, 59, 58, 55, 50, 43, 22, 21, 20, 15, 14, 10, 8, 6, 5, 4, 3, 1, 0],
                      [[93, 6, 1, 0], [87, 10, 3], [59, 22, 15, 4], [81, 14, 5], [100], [91, 8], [58, 21, 20], [55, 43], [98], [96], [50]]]
  test_data_table << [[51, 48, 40, 26, 26, 9],
                      [[51, 48], [40, 26, 26], [9]]] # BFD cannot find optimal solution for this case

  test_data_table.each do|values, bins|
    it "distributes set of #{values.size} values into bins" do
      expect(BestFitDecreasing.new(values, 100).distribute!).to eq(bins)
    end
  end
end
