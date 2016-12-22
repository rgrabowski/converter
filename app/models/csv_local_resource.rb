require 'open-uri'

class CsvLocalResource
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def file
    @file ||= Tempfile.new(tmp_filename, tmp_folder, encoding: encoding).tap do |f|
      io.rewind
      f.write(io.read)
      f.close
    end
  end

  private

  def uri
    URI.parse(url)
  end

  def io
    @io ||= uri.open
  end

  def encoding
    io.rewind
    io.read.encoding
  end

  def tmp_filename
    %w(rates- .csv)
  end

  def tmp_folder
    Rails.root.join('tmp')
  end

end