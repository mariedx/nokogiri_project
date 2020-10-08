require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))   

def c_names(page)
  array_names = []
  currency_names = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[2]/div/a')
  currency_names.each do |names|
  array_names << names.text
  end
  return array_names
end

def c_values(page)
  array_values = []
  currency_values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
  currency_values.each do |values|
  array_values << values.text
  end
  return array_values
end

def c_hash(page)
  hash_crypto = Hash[c_names(page).zip(c_values(page))]
  puts hash_crypto
end

c_hash(page)