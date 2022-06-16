#!/usr/bin/env ruby
require_relative 'lib/file_processor'
require_relative 'lib/algos/best_fit_decreasing'
require_relative 'lib/algos/brute_force'
require_relative 'lib/lower_bound'

time_budget = ARGV[2].to_i || 3
fp = FileProcessor.new(ARGV[0] || 'input.csv')
fp.read_file!
values = fp.get_values

optimal_packing = LowerBound.new(values).get_min_bins
shipments = BestFitDecreasing.new(values).distribute!
puts "Heuristic search arranged into #{shipments.size} shipments"
if optimal_packing < shipments.size && time_budget > 0
  puts "Optimal packing wasn't achieved by heuristics(#{optimal_packing}/#{shipments.size}), trying exhaustive search for #{time_budget} seconds..."
  begin
    shipments = BruteForce.new(values, optimal_packing, time_budget).distribute!
    puts "Optimal packing is achieved by exhaustive search: #{shipments.size} bins"
  rescue RuntimeError => e
    puts "#{e.message}. Keeping the heuristic results. Consider increasingr the time budget."
  end
end

fp.set_shipments(shipments)
fp.write_file!(ARGV[1] || 'output.csv')
