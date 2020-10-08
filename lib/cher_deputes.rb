require 'nokogiri'
require 'open-uri'

list = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))

def deputes_url(list)
  array_url = []
  urls = list.xpath('//a[contains(@href, "/deputes/fiche/")]')
  urls.each do |url|
    array_url << "http://www2.assemblee-nationale.fr/#{url['href'][1..-1]}"
  end
  return array_url
end

def deputes_email(list)
  array_emails = []
  deputes_url(list).each do |url|
    array_emails << Nokogiri::HTML(URI.open(url)).xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  end
  return array_emails
end

def deputes_first_name(list)
  first_name = []
  names = list.xpath('//a[contains(@href, "/deputes/fiche/")]')
  names.each do |name|
    first_name << name.text.split[1]
  end
  return first_name
end

def deputes_last_name(list)
  last_name = []
  names = list.xpath('//a[contains(@href, "/deputes/fiche/")]')
  names.each do |name|
    last_name << name.text.split[2]
  end
  return last_name
end

def perform(list)
    deputes_first_name(list)
    deputes_last_name(list)
    # deputes_email(list)
end

def array_final(list)
  array_final = []
  perform(list).each do |xx|
  array_final << {"first name" => deputes_first_name(xx), "last_name" => deputes_last_name(xx)}
  end
  return array_final
end

puts array_final(list)