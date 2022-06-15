class Bin
  SIZE = 2311

  def self.build(values:[], size: SIZE)
    values_arr = Array(values)
    values_arr.sum <= size ? new(values: values_arr, size: size) : nil
  end

  def initialize(values: [], size: SIZE)
    @size = size
    @content = values
  end

  def add(value)
    raise 'Not enough space' if free_space < value
    @content << value
    recalculate_free_space
  end

  def remove(value)
    raise 'Item not found' unless (position = @content.index(value))
    @content.delete_at(position)
    recalculate_free_space
  end

  def free_space
    @free_space || recalculate_free_space
  end

  def total_values
    @content.count
  end

  def fits?(value)
    free_space >= value
  end

  def to_a
    @content.sort.reverse!
  end

  private

  def recalculate_free_space
    @free_space = @size - @content.sum
  end
end
