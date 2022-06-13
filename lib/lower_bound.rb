# Estimated wasted space or L2 lower bound using in gaging the optimal solution
# Paper: https://doc.lagout.org/science/0_Computer%20Science/2_Algorithms/Knapsack%20Problems_%20Algorithms%20and%20Computer%20Implementations%20%5BMartello%20%26%20Toth%201990-11%5D.pdf
# Requires linear time.

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
    virtual_bins = []

    while @values.any?
      value = @values.pop

      virtual_bins << Bin.new(@size)
      virtual_bins.last.add(value)

      fitting_values, @values = @values.partition { |v| virtual_bins.last.fits?(v) }

      glued_value = fitting_values.sum || 0
      glued_value = insert_glued_value(virtual_bins, glued_value)

      while glued_value > @size
        virtual_bins << Bin.new(@size)
        glued_value = insert_glued_value(virtual_bins, glued_value)
      end

      @values << glued_value if glued_value > 0
    end

    virtual_bins.sum(&:free_space) || 0
  end

  def insert_glued_value(virtual_bins, glued_value)
    stay_value = [virtual_bins.last.free_space, glued_value].min
    virtual_bins.last.add(stay_value) if stay_value > 0
    glued_value - stay_value
  end

end
