require "rubygems"
require "nokogiri"
require "open-uri"

answer_values = ["ballon", "rpg", "mars", "helicopter"]

scraped_products = []

answer = answer_values.sample(2)

html_content = URI.open("https://www.etsy.com/au/search?q=#{answer[0].gsub(" ", "+")}+#{answer[1].gsub(" ", "+")}", "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
# 2. We build a Nokogiri document from this file
p html_content
doc = Nokogiri::HTML.parse(html_content)
p doc
