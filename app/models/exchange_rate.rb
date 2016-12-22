class ExchangeRate < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :rate, presence: true, numericality: true
end