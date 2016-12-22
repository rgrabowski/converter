require 'rails_helper'
require 'csv'
vcr_options = {:cassette_name => 'exchange_rates_csv', :record => :once}

RSpec.describe CsvLocalResource, vcr: vcr_options do

  describe '#file' do
    let(:url) { 'http://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv' }
    let(:file) { CsvLocalResource.new(url).file }

    it 'returns tempfile' do
      expect(CSV.read(file.path)[6][1]).to eq('1.0644')
    end
  end
end