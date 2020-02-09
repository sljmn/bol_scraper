require 'watir'
require 'open-uri'
require 'net/http'
require 'nokogiri'

b = Watir::Browser.new :chrome, headless: true





b.goto 'https://www.bol.com/nl/s/?searchtext=0190199223189' #item with 9 qty 7426870705815 meer qty: 7435127091076
sleep 1
puts "thank you, working...."
p = Nokogiri::HTML.parse(b.html)

# grab product name
product = p.xpath("/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[2]/div/div[1]/a").text
puts "product:" + product

#grab main seller

main_seller = p.xpath("/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[2]/wsp-buy-block/div[3]").text
puts "main seller is #{main_seller.strip}"

#grab image

image = p.xpath("/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[1]/div/a/wsp-skeleton-image/div/img//@src")
puts "image is #{image}"

price = p.xpath "/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[2]/wsp-buy-block/div[1]/section/div/div/span/text()"
puts "price is #{price}"

#go to product page
puts "going to product page"
b.a(:xpath => '/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[2]/div/div[1]/a').click

sleep 2

puts "trying to find the button"

variant1 = b.a({text: "In winkelwagen"})
variant2 = b.a({text: "In mijn winkelwagen"})

if variant1.exists? then
  variant1.click
else variant2.exists?
    variant2.click
end


puts "button found"
puts "button clicked"



puts "working...."
sleep 1

puts "sending to b...."

#close modal
b.send_keys :escape
puts "close the model"

sleep 2

#go to shopping basket
puts "go to b...."
b.element(:xpath => "/html/body/div/header/div/div[3]/a[3]").click
sleep 2

puts "select the right item"
last_item_in_qty  = b.element(:css => "#tst_quantity_dropdown option:last-child").text

b.element(:xpath => "/html/body/div/main/div[3]/div/div/div[3]/div/div/div[1]/div/form/fieldset/div[2]/div/select/option[last()]").click


if last_item_in_qty.include? "meer"
  puts "changing the item to make it work"
  #b.element(:xpath => "/html/body/div[2]/div[2]/div[3]/div[2]/div[2]/div/a").click
  #increase qty: select list
  b.text_field(:css => ".text-input--two-digits").set'500'
  # b.element(:xpath => "/html/body/div/main/div[3]/div/div/div[3]/div/div/div[1]/div/form/fieldset/div[2]/div/select").click
  b.send_keys :enter
  sleep 2
  puts "doing the magic"

  endresult = b.element(:xpath => '/html/body/div/main/div[2]/ul/li')
  current_stock = b.element(:xpath => "/html/body/div/main/div[2]/ul/li/b[2]")

else
puts "there is no need for extra work"
current_stock = b.element(:xpath => "/html/body/div/main/div[3]/div/div/div[3]/div/div/div[1]/div/form/fieldset/div[2]/div/select/option[last()]")
end

puts "current stock is " + current_stock.text
