require 'watir'
require 'open-uri'
require 'net/http'
require 'csv'
require 'nokogiri'

b = Watir::Browser.new :chrome, headless: false

b.goto 'https://www.bol.com/nl/s/?searchtext=7435127091076'
p = Nokogiri::HTML.parse(b.html)
sleep 2
product = p.css("a.product-title.px_list_page_product_click").text
price = p.xpath "/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[2]/wsp-buy-block/div[1]/section/div/div/span/text()"
main_seller = p.css(".tooltip-link--dashed").text

image = p.xpath("/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[1]//@src")
puts image #url

puts "#{product}, verkocht door #{main_seller.strip.chomp} voor €#{price}"

sleep 2

b.element(:xpath => "/html/body/div/main/wsp-async-browse/div/div/div[3]/div/div[1]/div/div[4]/wsp-async-browse-product-list/ul/li/div[2]/wsp-buy-block/div[4]/div/a").click
sleep 2

close modal
b.send_keys :escape

klik op basket
b.element(:xpath => "/html/body/div/header/div/div[3]/a[3]").click

sleep 2

b.element(:xpath => "/html/body/div[2]/div[2]/div[3]/div[2]/div[2]/div/a").click
increase qty: select list
b.element(:xpath => "/html/body/div/main/div[3]/div/div/div[3]/div/div/div[1]/div/form/fieldset/div[2]/div/select").click
sleep 2

increase qty: enter qty
all_options = b.select_list({id: "tst_quantity_dropdown"}).options[-1].select

all_options = b.element(:xpath => "/html/body/div/main/div[3]/div[2]/div/div[3]/div/div/div[1]/div/form/fieldset/div[2]/div/select[last()]")
fill in input
sleep 2

if there is MEER text in dropdown menu use this below, otherwise skip
b.text_field(:css => ".text-input--two-digits").set'100'

b.send_keys :enter

/html/body/div/main/div[2]/ul/li
endresult = b.element(:xpath => '/html/body/div/main/div[2]/ul/li')

puts endresult.text
current_stock = b.element(:xpath => "/html/body/div/main/div[2]/ul/li/b[2]")
puts current_stock.text
