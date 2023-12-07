
require "json"
require "open-uri"

answer =  ["Horror", "Pop", "Fantasy", "Painting", "MacBook"]
scraped_products = []


answer.each do |ans|
  encoded_answer = ans.gsub(" ", "%20")

  url = "https://api.bestbuy.com/v1/products((search=#{encoded_answer}))?apiKey=TEaoEZmvBDYZWr2hHVcHOZHY&sort=regularPrice.asc&show=regularPrice,shortDescription,name,image,thumbnailImage&pageSize=20&format=json"
  p url
  url_serialized = URI.open(url).read
  results = JSON.parse(url_serialized)

  # Save the results to a JSON file named with the current date and search term
  File.open("results_#{Date.today}_#{ans}.json", "w") do |f|
    f.write(results.to_json)
  end

  if results["total"] > 0
    result = results["products"].first
    scraped_products << {
      name: result["name"],
      price: result["regularPrice"],
      image_url: result["image"],
      ans: ans  # Added to track which search term resulted in this product
    }
  end

end

p scraped_products
