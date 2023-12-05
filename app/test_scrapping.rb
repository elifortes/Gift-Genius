require "open-uri"
require "nokogiri"

# Function to extract first two elements' contents for a given selector
def extract_first_two(doc, selector)
  elements = doc.css(selector).take(2)
  elements.map { |element| element.content.strip rescue 'Not found' }
end

# Function to extract first two image URLs for a given selector
def extract_first_two_images(doc, selector)
  elements = doc.css(selector).take(2)
  elements.map { |element| element['src'] rescue 'Not found' }
end

answers = ["Cooking", "Animation", "Disco", "Contemporary Fiction", "Apple", "Cave", "Fighting", "French", "Canon EOS Camera", "Bookmarks"]

answers.each do |answer|
  url = "https://www.amazon.com.au/s?k=#{answer.gsub(' ', '+')}+for+adult&s=date-desc-rank&crid=1NPJG8DRL1OB5&qid=1701761808&sprefix=binoculars+for+adult%2Caps%2C263&ref=sr_st_date-desc-rank&ds=v1%3AXl0ZP7a2L%2Ff5BvRu%2FhDncNXfklqFiyXzl7pUoG6zS0A"
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)

  # Extracting first two product names, prices, and image URLs
  first_two_names = extract_first_two(html_doc, 'h2')
  first_two_prices = extract_first_two(html_doc, 'span.a-price-whole')
  first_two_images = extract_first_two_images(html_doc, 'div.a-section.aok-relative.s-image-square-aspect img')

  # Output the results for each answer
  puts "Answer: #{answer}"
  first_two_names.each_with_index do |name, index|
    puts "Product #{index + 1} Name: #{name}"
    puts "Product #{index + 1} Price: #{first_two_prices[index]}"
    puts "Product #{index + 1} Image URL: #{first_two_images[index]}"
    puts "\n" # For better readability
  end
end




# For One product :

  require "open-uri"
require "nokogiri"

answers = ["Cooking", "Animation", "Disco", "Contemporary Fiction", "Nike", "Cave", "Fighting", "French", "Canon EOS Camera", "Bookmarks"]

answers.each do |answer|
  url = "https://www.amazon.com.au/s?k=#{answer.gsub(' ', '+')}+for+adult&s=date-desc-rank&crid=1NPJG8DRL1OB5&qid=1701761808&sprefix=binoculars+for+adult%2Caps%2C263&ref=sr_st_date-desc-rank&ds=v1%3AXl0ZP7a2L%2Ff5BvRu%2FhDncNXfklqFiyXzl7pUoG6zS0A"
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)

  first_product_name_element = html_doc.css('h2').first
  first_product_name = first_product_name_element ? first_product_name_element.content.strip : 'Not found'

  first_product_price_element = html_doc.css('span.a-price-whole').first
  first_product_price = first_product_price_element ? first_product_price_element.content.strip : 'Not found'

  first_product_image_element = html_doc.css('div.a-section.aok-relative.s-image-square-aspect img').first
  first_product_image_url = first_product_image_element ? first_product_image_element['src'] : 'Not found'

  # Output the results for each answer
  puts "Answer: #{answer}"
  puts "First Product Name: #{first_product_name}"
  puts "First Product Price: #{first_product_price}"
  puts "First Product Image URL: #{first_product_image_url}"
  puts "\n" # For better readability
end



# # For Random product:
# require "open-uri"
# require "nokogiri"
# require "securerandom"

# answers = ["Cooking", "Animation", "Disco", "Contemporary Fiction", "Nike", "Cave", "Fighting", "French", "Canon EOS Camera", "Bookmarks"]

# answers.each do |answer|
#   url = "https://www.amazon.com.au/s?k=#{answer.gsub(' ', '+')}+for+adult&s=date-desc-rank&crid=1NPJG8DRL1OB5&qid=1701761808&sprefix=binoculars+for+adult%2Caps%2C263&ref=sr_st_date-desc-rank&ds=v1%3AXl0ZP7a2L%2Ff5BvRu%2FhDncNXfklqFiyXzl7pUoG6zS0A"
#   html_file = URI.open(url).read
#   html_doc = Nokogiri::HTML(html_file)

#   product_elements = html_doc.css('div[data-component-type="s-search-result"]')
#   random_product = product_elements[SecureRandom.random_number(product_elements.size)]

#   product_name = random_product.at_css('h2')&.content&.strip || 'Not found'
#   product_price = random_product.at_css('span.a-price-whole')&.content&.strip || 'Not found'
#   product_image_url = random_product.at_css('img.s-image')['src'] rescue 'Not found'

#   # Output the results for each answer
#   puts "Answer: #{answer}"
#   puts "Random Product Name: #{product_name}"
#   puts "Random Product Price: #{product_price}"
#   puts "Random Product Image URL: #{product_image_url}"
#   puts "\n" # For better readability
# end
