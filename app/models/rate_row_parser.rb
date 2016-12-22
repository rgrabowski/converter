class RateRowParser
  attr_accessor :date, :rate

  def initialize(row)
    @date = row[0]
    @rate = row[1].to_f
  end

  def build
    ExchangeRate.new(date: date, rate: rate)
  end
end