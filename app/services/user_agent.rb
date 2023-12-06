scraped_products = []
answer_values = [["Comedy", "Canon EOS Camera"], ["Fantasy", "Country"], ["H&M", "French"], ["", "Botanical Garden"], ["Cycling", "Arcade"]]
answer = answer_values.sample
answer = ["Fantasy"]
require "json"
require "open-uri"
scraped_products = []

url = "https://api.bestbuy.com/v1/products((search=#{answer[0]}))?apiKey=TEaoEZmvBDYZWr2hHVcHOZHY&sort=regularPrice.asc&show=regularPrice,shortDescription,name,image,thumbnailImage&pageSize=5&format=json"
p url
url_serialized = URI.open(url).read
results = JSON.parse(url_serialized)
File.open("results#{Date.new}.json", "w") do |f|
  f.write(results.to_json)
end
if results["total"] > 0
  p result = results["products"].first
  scraped_products << {
    name: result["name"],
    price: result["regularPrice"],
    image_url: result["image"],
  }
end
p scraped_products

{
  "regularPrice" => 4.49,
  "shortDescription" => nil,
  "name" => "Wizards of The Coast - Magic the Gathering March of the Machine The Aftermath Draft Booster Sleeve",
  "image" => "https://pisces.bbystatic.com/prescaled/500/500/image2/BestBuy_US/images/products/6539/6539367_sd.jpg",
  "thumbnailImage" => "https://pisces.bbystatic.com/prescaled/108/54/image2/BestBuy_US/images/products/6539/6539367_sd.jpg",
}
