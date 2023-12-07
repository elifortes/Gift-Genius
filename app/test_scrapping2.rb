
# <---- AMAZON   ---->
def gift_scrapper
    require "open-uri"
    require "nokogiri"


    scraped_products = []
    @answer_values.each do |answer|
      url = "https://www.amazon.com.au/s?k=#{answer.gsub(' ', '+')}+for+adult"
      html_file = URI.open(url).read
      html_doc = Nokogiri::HTML(html_file)
      first_product_name_element = html_doc.css('h2').first
      first_product_name = first_product_name_element ? first_product_name_element.content.strip : 'Not found'

      first_product_price_element = html_doc.css('span.a-price-whole').first
      first_product_price = first_product_price_element ? first_product_price_element.content.strip : 'Not found'

      first_product_image_element = html_doc.css('div.a-section.aok-relative.s-image-square-aspect img').first
      first_product_image_url = first_product_image_element ? first_product_image_element['src'] : 'Not found'

      scraped_products << {
        name: first_product_name,
        price: first_product_price,
        image_url: first_product_image_url
      }
    end
    scraped_products
  end

# <---- ESTY   ---->


require "open-uri"
require "nokogiri"

def gift_scraper(answer_values)
  scraped_products = []
  answer_values.each do |answer|
    # Constructing the URL with the first two elements of 'answer' array
    url = "https://www.etsy.com/au/search?q=#{answer[0].gsub(' ', '+')}+#{answer[1].gsub(' ', '+')}"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)


    first_product_name_element = html_doc.css('h2').first
    first_product_name = first_product_name_element ? first_product_name_element.content.strip : 'Not found'


    first_product_image_element = html_doc.css('div.a-section.aok-relative.s-image-square-aspect img').first
    first_product_image_url = first_product_image_element ? first_product_image_element['src'] : 'Not found'


    first_product_price_element = html_doc.css('span.a-price-whole').first
    first_product_price = first_product_price_element ? first_product_price_element.content.strip : 'Not found'

    scraped_products << {
      name: first_product_name,
      price: first_product_price,
      image_url: first_product_image_url
    }
  end
  scraped_products
end

# gifts_categories = [
#   {
#       "id": 1,
#       "name": "Movies",
#       "categories": [
#           "pcmcat1680806209177" # bluray tv shows
#       ]
#   },
#   {
#       "id": 2,
#       "name": "Electronics"
#       "categories": [
#           "abcat0500000", # Computers and Tablets
#           "pcmcat1586900952752", # Xbox
#       ]
#   }
# ]

# When the person gets to the /questions page
# it asks the question: "what is that the person likes?"
# it will list the options available on "gifts_categories" variable/database

# what is that the person likes?
#   - Movies
#   - Electronics

# when the user clicks in one of the options
# say the person selects "Electronics" the controller will search the BestBuy API for products
# from categories "abcat0500000" "pcmcat1586900952752" and show the list of the products retrieved

# the person then needs to click on a product name to select

# click submit to save the questionnaire answers

# questionnaire data will look like:
# id: identify on db the answer
# group_id:
# user_id: who filled the questionnaire
# category_id: gifts_categories
# product_id: product selected (sku)
