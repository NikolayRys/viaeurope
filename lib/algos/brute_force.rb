# Brute force with some branch-pruning

class BruteForce
  def initialize(values, lower_bound=0, size=Bin::SIZE)
    @values = values.sort
    @lower_bound = lower_bound
    @size = size
  end

  def distribute!
    find_distribution(@values, @lower_bound, @size)
  end

  private

  def find_distribution(all_items, bins, size)
    return [] if all_items.empty?

    min_items = bins == 1 ? all_items.size : 1 # If one bin left, put all items in it
    max_items = all_items.size - bins + 1 # Limit the items to make sure there are no any empty bins

    core_item = all_items.first

    core_bin_variants = Enumerator.new do |y| # Use Enumerator to not instantiate the array in memory
      (min_items..max_items).each do |items_in_bin|
        all_items.drop(1).combination(items_in_bin - 1).each { |c| y << c.unshift(core_item) }
      end
    end

    core_bin_variants.each do |core_bin|
      next if core_bin.sum > size

      other_bins = find_distribution(all_items - core_bin, bins - 1, size)
      return other_bins.unshift(core_bin) if other_bins
    end

    nil
  end

end
