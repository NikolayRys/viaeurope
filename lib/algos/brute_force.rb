# Brute force with some branch-pruning

require_relative '../bin'

class BruteForce
  def initialize(values, lower_bound, budget=5, size=Bin::SIZE)
    @values = values.sort
    @lower_bound = lower_bound
    @size = size
    @budget = budget
  end

  def distribute!
    @start_time = Time.now
    distribute_recursively(@values, @lower_bound).map(&:to_a)
  end

  private

  def distribute_recursively(all_values, bins)
    raise Timeout::Error, 'Time limit reached' if Time.now - @start_time > @budget
    return [] if all_values.empty?

    core_bin_variants = build_bin_enumerator(all_values, bins)

    core_bin_variants.each do |core_bin, other_values|
      other_bins = distribute_recursively(other_values, bins - 1)
      return other_bins.unshift(core_bin) if other_bins
    end

    nil
  end

  def build_bin_enumerator(all_values, bins)
    min_items = bins == 1 ? all_values.size : 1 # If one bin left, put all items in it
    max_items = all_values.size - bins + 1 # Limit the items to make sure there are no any empty bins
    Enumerator.new do |y| # Use Enumerator to not instantiate the arrays in memory
      (min_items..max_items).each do |items_in_bin|
        all_values.drop(1).combination(items_in_bin - 1).each { |c|
          bin_values = c.unshift(all_values.first)
          bin = Bin.build(values: bin_values, size: @size)
          y << [bin, all_values - bin_values] if bin # Prune branch if the permutation doesnt fit
        }
      end
    end
  end

end
