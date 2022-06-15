# Brute force with some branch-pruning
# We can add the number of bins completed to the sum of the remaining elements, divided by the bin capacity and rounded up.


class BruteForce
  def initialize(values, lower_bound=0, size=Bin::SIZE)
    @values = values.sort
    @lower_bound = lower_bound
    @size = size
  end

  def distribute!

  end

  private


  def find_distribution(all_items, bins, size)
    return [] if all_items.empty?

    # If one bin left, put all items in it
    min_items = bins == 1 ? all_items.size : 1

    # Limit the items to make sure there are no any empty bins
    max_items = all_items.size - bins + 1

    core_item = all_items.first
    core_bin_variants = []

    (min_items..max_items).each do |number_of_items|
      core_bin_variants.concat(all_items.drop(1).combination(number_of_items - 1).reject{|values| core_item + values.sum > size })
    end

    # Enumerator.new { |y|
    #   (min_items..max_items).each do |number_of_items|
    #     all_items.drop(1).combination(number_of_items - 1).each{|enum| enum.each { |i| y << i } }
    #   end
    # }.reject{|values| core_item + values.sum > size }


    core_bin_variants.map! { |values| [core_item] + values }

    core_bin_variants.each do |core_bin|
      other_bins = find_distribution(all_items - core_bin, bins - 1, size)

      if other_bins && ([core_bin] + other_bins).flatten.size == all_items.size
        return [core_bin] + other_bins
      end
    end
  end


end
