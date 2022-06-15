# Estimated wasted space or L2 lower bound using in gaging the optimal solution
# Paper: https://doc.lagout.org/science/0_Computer%20Science/2_Algorithms/Knapsack%20Problems_%20Algorithms%20and%20Computer%20Implementations%20%5BMartello%20%26%20Toth%201990-11%5D.pdf
# Requires linear time.

require_relative 'bin'

class LowerBound
  def initialize(values, size=Bin::SIZE)
    @values = values.sort
    @size = size
  end

  def get_min_bins
    total_values = @values.sum
    waste = get_estimated_waste
    (total_values + waste) / @size
  end

  private

  def get_estimated_waste
    wasted_space = 0

    while @values.any?
      value = @values.pop

      bin = Bin.new(size: @size)
      bin.add(value)

      fitting_values, @values = @values.partition { |v| bin.fits?(v) }

      glued_value = fitting_values.sum
      kept_value  = [bin.free_space, glued_value].min
      if kept_value.positive?
        bin.add(kept_value)
        glued_value -= kept_value
      end
      glued_value -= @size while glued_value > @size

      wasted_space += bin.free_space
      @values << glued_value if glued_value.positive?
    end

    wasted_space
  end

end
