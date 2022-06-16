require 'csv'

class FileProcessor
  def initialize(file_path)
    @file_path = file_path
  end

  def read_file!
    @parcels = CSV.read('input.csv', headers: true)
    puts "Reading CSV file, found #{@parcels.entries.size} parcels"
  end

  def get_values
    @tally = @parcels.entries.inject(Hash.new(0)){|tally, p| tally[p['client_name']] += p['weight'].to_i ; tally}
    values = @tally.values
    puts "#{values.size} clients detected"
    values
  end

  def set_shipments(packing)
    packing.each_with_index do |weights, index|
      weights.each do |weight|
        @tally[@tally.key(weight)] = "shipment #{index + 1}"
      end
    end
    @parcels.map{|p| p['shipment_ref'] = @tally[p['client_name']]}
  end

  def write_file!(file_path)
    puts "Writing output file"
    File.write(file_path, @parcels.to_csv)
  end
end
