require "open-uri"
require "nokogiri"

class GiftsScraper
  URL = "https://www.amazon.com.au/s?k=Binoculars+for+adults&crid=2BWAFZ5BUHU2C&sprefix=binoculars+for+adults%2Caps%2C278&ref=nb_sb_noss_1"

  def self.call
    new.call
  end

  def call
    html_file = URI.open(URL).read
    html_doc = Nokogiri::HTML.parse(html_file)
    scrape_data(html_doc)
  end

  private

  def scrape_data(html_doc)
    html_doc.search(".s-widget-container").map do |element|
      {
        text: element.text.strip,
        href: element.attribute("href")&.value,
      }
    end
  end
end

# example to call in controller:

# class GiftController < ApplicationController
#   def index
#     @binoculars_data = GiftsScraper.call
#     # Handle @binoculars_data as needed (e.g., display in views, log, etc.)
#   end
# end
