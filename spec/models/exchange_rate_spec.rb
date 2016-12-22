require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do

  context 'when rate is -' do
    let(:args) { {date: '2016-11-17', rate: '-'} }
    subject { ExchangeRate.new(args) }

    it 'is not valid' do
      expect(subject.valid?).to be false
    end
  end

  context 'when rate is empty' do
    let(:args) { {date: '2016-11-17', rate: ''} }
    subject { ExchangeRate.new(args) }

    it 'is not valid' do
      expect(subject.valid?).to be false
    end
  end

  context 'when date is empty' do
    let(:args) { {date: nil, rate: '0.2345'} }
    subject { ExchangeRate.new(args) }

    it 'is not valid' do
      expect(subject.valid?).to be false
    end
  end

  context 'when date is uniqueness' do
    let!(:exchange_rate) { FactoryGirl.create(:exchange_rate, date: Date.today, rate: 0.1234) }
    let(:args) { {date: Date.today, rate: '0.2345'} }
    subject { ExchangeRate.new(args) }

    it 'is not valid' do
      expect(subject.valid?).to be false
    end
  end

end