namespace :rates do
  desc 'Update rates table'

  task update: :environment do
    puts "Number of records: #{ExchangeRate.count}"
    puts "Last record from: #{ExchangeRate.order(date: :asc).last.try(:date) || '-'}"

    puts 'Processing ...'
    RatesUpdater.new(file).update
    puts 'Done'
    puts "Number of records: #{ExchangeRate.count}"
    puts "Last record from: #{ExchangeRate.order(date: :asc).last.try(:date) || '-'}"
  end

  def self.file
    CsvLocalResource.new(url).file
  end

  def self.url
    'http://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'
  end

end
