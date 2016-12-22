class ExchangeRateConverter
  attr_accessor :original_amount, :date

  def self.convert(amount, date)
    new(amount, date).convert
  end

  def initialize(original_amount, date)
    @original_amount = original_amount
    @date = date.to_date
  end

  def convert
    ConversionResult.build(conversion_date: conversion_date,
                           original_amount: original_amount,
                           converted_amount: converted_amount,
                           exchange_rate: exchange_rate,
                           errors: errors)
  end

  private

  def exchange_rate_data
    @exchange_rate_data ||= ExchangeRate.find_by(date: conversion_date)
  end

  def exchange_rate
    if exchange_rate_data.present?
      errors << {error: :weekend_adjusted_date, data: "#{conversion_date}"} if adjusted_date?
      exchange_rate_data.rate.to_f
    else
      errors << {error: :rate_not_determined, data: ''}
      nil
    end
  end

  def conversion_date
    if date.on_weekend?
      date.last_weekday
    else
      date
    end
  end

  def adjusted_date?
    date != conversion_date
  end

  def converted_amount
    return nil if exchange_rate.nil?
    (original_amount / exchange_rate).round(2)
  end

  def errors
    @errors ||= []
  end

end