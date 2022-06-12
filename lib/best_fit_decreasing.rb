# Best-fit-decreasing (BFD) algorithm for heuristic search
# https://en.wikipedia.org/wiki/Best-fit_bin_packing
require_relative 'bin'

class BestFitDecreasing
  def initialize(values, size=Bin::SIZE)
    @values = values
    @bins = []
    @size = size
  end

  def distribute!
    @values.sort!.reverse!
    @values.each do |value|
      bin_id = find_bin(value)
      bin_id ? insert_into_bin(bin_id, value) : insert_into_new_bin(value)
    end
    @bins.map(&:to_a)
  end

  private

  def find_bin(value)
    @bins.index { |bin| bin.fits?(value) }
  end

  def insert_into_bin(bin_id, value)
    bin = @bins.delete_at(bin_id)
    place_bin(bin, value)
  end

  def insert_into_new_bin(value)
    bin = Bin.new(@size)
    place_bin(bin, value)
  end

  def place_bin(bin, value)
    bin.add(value)
    remaining_space = bin.free_space
    new_index = @bins.index { |bin| bin.fits?(remaining_space) } || @bins.size
    @bins.insert(new_index, bin)
  end
end
