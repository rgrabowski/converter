require 'rails_helper'

RSpec.describe ExchangeRateConverter do

  describe '#convert' do

    context 'when conversion date is on weekday' do
      let!(:exchange_rates) { FactoryGirl.create(:exchange_rate, date: '2011-03-03', rate: 1.3957) }

      subject { ExchangeRateConverter.convert(120, '2011-03-03') }

      it 'returns original amount' do
        expect(subject.original_amount).to eq(120)
      end

      it 'returns conversion_date' do
        expect(subject.conversion_date).to eq('2011-03-03'.to_date)
      end

      it 'returns converted_amount' do
        expect(subject.converted_amount).to eq(85.98)
      end

      it 'returns exchange_rate' do
        expect(subject.exchange_rate).to eq(1.3957)
      end

      it 'returns errors' do
        expect(subject.errors).to eq([])
      end

    end

    context 'when conversion date is on weekend' do
      let!(:exchange_rates) { FactoryGirl.create(:exchange_rate, date: '2011-03-04', rate: 1.3957) }

      subject { ExchangeRateConverter.convert(120, '2011-03-05') }

      it 'returns original amount' do
        expect(subject.original_amount).to eq(120)
      end

      it 'returns conversion_date' do
        expect(subject.conversion_date).to eq('2011-03-04'.to_date)
      end

      it 'returns converted_amount' do
        expect(subject.converted_amount).to eq(85.98)
      end

      it 'returns exchange_rate' do
        expect(subject.exchange_rate).to eq(1.3957)
      end

      it 'returns errors' do
        output = [{:error=>:weekend_adjusted_date, :data=>"2011-03-04"}]
        expect(subject.errors).to eq(output)
      end
    end

    context 'when exchange rate is not determined' do
      let!(:exchange_rates) { FactoryGirl.create(:exchange_rate, date: '2011-03-01', rate: 1.3957) }

      subject { ExchangeRateConverter.convert(120, '2011-03-05') }

      it 'returns original amount' do
        output =  [{:error=>:rate_not_determined, :data=>""}]
        expect(subject.errors).to eq(output)
      end
    end

  end
end