

require "open-uri"
require "nokogiri"

answers = "Binoculars"
url = "https://www.amazon.com.au/s?k=Binoculars+for+adults&crid=2BWAFZ5BUHU2C&sprefix=binoculars+for+adults%2Caps%2C278&ref=nb_sb_noss_1"
# url = "https://www.bbcgoodfood.com/search/recipes?q=#{ingredient}"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)

first_product_name_element = html_doc.css('h2').first
first_product_name = first_product_name_element ? first_product_name_element.content.strip : 'Not found'

# Adjust the selector for the price based on your HTML structure
first_product_price_element = html_doc.css('span.a-price-whole').first
first_product_price = first_product_price_element ? first_product_price_element.content.strip : 'Not found'

# Output the results
puts "First Product Name: #{first_product_name}"
puts "First Product Price: #{first_product_price}"
