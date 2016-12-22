class ConversionResult
  attr_accessor :conversion_date, :original_amount, :converted_amount, :exchange_rate, :errors

  def self.build(args = {})
    new(args)
  end

  def initialize(args = {})
    @conversion_date  = args[:conversion_date]
    @original_amount  = args[:original_amount]
    @converted_amount = args[:converted_amount]
    @exchange_rate    = args[:exchange_rate]
    @errors           = args[:errors].uniq
  end
end