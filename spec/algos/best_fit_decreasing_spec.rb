require_relative 'spec_helper'
require_relative '../../lib/algos/best_fit_decreasing'

describe BestFitDecreasing do

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
                      [[93, 4, 2], [94, 5], [99], [97], [8]],
                      100]
  test_data_table << [[100, 98, 96, 93, 91, 87, 81, 59, 58, 55, 50, 43, 22, 21, 20, 15, 14, 10, 8, 6, 5, 4, 3, 1, 0],
                      [[93, 6, 1, 0], [87, 10, 3], [59, 22, 15, 4], [81, 14, 5], [100], [91, 8], [58, 21, 20], [55, 43], [98], [96], [50]],
                      100]
  test_data_table << [[51, 48, 40, 26, 26, 9],
                      [[51, 48], [40, 26, 26], [9]], # BFD cannot find optimal solution for this case
                      100]
  test_data_table << [[1262, 1227, 1049, 961, 945, 667, 650, 621, 567, 567, 564, 560, 536, 419, 312],
                      [[621, 564, 560, 536], [667, 650, 567, 419], [961, 945, 312], [1227, 1049], [1262]],
                      2311]

  test_data_table.each do|values, bins, size|
    it "distributes set of #{values.size} values into bins of #{size}" do
      expect(BestFitDecreasing.new(values, 100).distribute!).to eq(bins)
    end
  end
end
