require 'nokogiri'
require 'open-uri'

valedoise = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

def get_townhall_urls(valedoise)
  array_cities = []
  valedoise_cities = valedoise.xpath('//a[contains(@href, "./95/")]')
  valedoise_cities.each do |cities|
  array_cities << "http://annuaire-des-mairies.com#{cities['href'][1..-1]}"
  end
  return array_cities
end

def get_townhall_email(valedoise)
  array_emails = []
  get_townhall_urls(valedoise).each do |url|
  array_emails << Nokogiri::HTML(URI.open(url)).xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  end
  return array_emails
end

def towns_names(valedoise)
  array_cities = []
  valedoise_cities = valedoise.xpath('//a[contains(@href, "./95/")]')
  valedoise_cities.each do |cities|
  array_cities << cities.text
  end
  return array_cities
end

def hash_1(valedoise)
  hash_towns = Hash[towns_names(valedoise).zip(get_townhall_email(valedoise))]

  array_final = []
  hash_towns.each do |cities, emails|
  array_final << {cities => emails}
  end
  return array_final
end



