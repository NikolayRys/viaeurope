class Bin
  SIZE = 2311

  def initialize(size=SIZE)
    @content = []
    @size = size
  end

  def add(value)
    raise 'Not enough space' if free_space < value
    @content << value
  end

  def remove(value)
    raise 'Item not found' unless (position = @content.index(value))
    @content.delete_at(position)
  end

  def free_space
    @size - @content.sum
  end

  def total_values
    @content.count
  end
end
