require_relative 'spec_helper'
require_relative '../lib/bin'

describe Bin do

  describe 'instance' do
    let(:bin) { Bin.new }
    it 'is initialized with a default size' do
      expect(bin.free_space).to eq(Bin::SIZE)
    end

    it 'adds a value' do
      bin.add(1)
      expect(bin.free_space).to eq(Bin::SIZE - 1)
    end

    it 'removes a value' do
      bin.add(1)
      bin.remove(1)
      expect(bin.free_space).to eq(Bin::SIZE)
    end

    it 'raises an error when trying to remove a value that is not in the bin' do
      bin.add(1)
      expect { bin.remove(2) }.to raise_error('Item not found')
    end

    it 'displayes the total number of values' do
      bin.add(1)
      bin.add(2)
      expect(bin.total_values).to eq(2)
    end

    it 'checks if value fits' do
      expect(bin.fits?(5000)).to be_falsey
    end
  end

  describe 'factory' do
    it 'mass assigns values' do
      bin = Bin.build(values: [1, 2, 3])
      expect(bin.total_values).to eq(3)
      expect(bin.free_space).to eq(Bin::SIZE - 6)
    end

    it 'does not return bin if does not fit' do
      expect(Bin.build(values: [2000, 3000, 3])).to be_nil
    end
  end
end
