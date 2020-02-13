require 'httparty'
require 'json'
require 'active_support/core_ext/hash'


url = 'https://api.bol.com/catalog/v4/products/9200000113167728?apikey=ECC507AE2CBC4F5B9B2B394A62D3C264&includeAttributes=false&format=json&offers=all'
response = HTTParty.get(url).parsed_response




 products = response.first[1].last

 #title
title = products.fetch("title")
puts title
#ean
ean = products.fetch("ean")
puts ean
#merk
merk = products.fetch("specsTag")
puts merk

#Product image
images = products.fetch("images")[4].values_at("url")
puts images


offerdata = products.fetch("offerData")

offers = offerdata.fetch("offers")


offers.each do |key|

  next if key["seller"]["displayName"] == "bol.com"

    puts "Offer Id is #{key["id"]}"
    puts "Price is €#{key["price"]}"
    puts "availabilityDescription is #{key["availabilityDescription"]}"
    puts "Seller is #{key["seller"]["displayName"]}"
    puts "deliveryTimeRating is #{key["seller"]["sellerRating"]["deliveryTimeRating"]}"
    puts "productInformationRating is #{key["seller"]["sellerRating"]["productInformationRating"]}"
    puts "deliveryTimeRating is #{key["seller"]["sellerRating"]["deliveryTimeRating"]}"
    puts "shippingRating is #{key["seller"]["sellerRating"]["shippingRating"]}"



  end
