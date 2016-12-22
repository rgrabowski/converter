require 'csv'
class RatesUpdater
  attr_accessor :file

  def initialize(file)
    @file = file
  end

  def update
    begin
      process_file
    ensure
      file.close
      file.unlink
    end
  end

  private

  def process_file
    CSV.foreach(file.path) do |row|
      next if rate_row_data(row).invalid?

      if ExchangeRate.find_by(date: rate_row_data(row).date).nil?
        rate_row_data(row).save
      end
    end
  end

  def rate_row_data(row)
    RateRowParser.new(row).build
  end

end