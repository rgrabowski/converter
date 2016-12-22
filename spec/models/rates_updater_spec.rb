require 'rails_helper'
vcr_options = {:cassette_name => 'exchange_rates_csv', :record => :once}

RSpec.describe RatesUpdater, vcr: vcr_options do
  let(:url) { 'http://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv' }
  let(:file) { CsvLocalResource.new(url).file }

  describe '#update' do

    context 'when database is empty' do
      it 'creates all rates rows from file' do
        expect { RatesUpdater.new(file).update }.to change(ExchangeRate, :count).by(10)
      end
    end

    context 'when some records are already persisted' do
      before { ExchangeRate.create(date: '2016-12-15', rate: '1.0419') }

      it 'creates only new rates rows' do
        expect { RatesUpdater.new(file).update }.to change(ExchangeRate, :count).by(9)
      end
    end

  end
end