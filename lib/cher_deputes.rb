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

def array_final(list)
  first = deputes_first_name(list)
  last = deputes_last_name(list)
  # emails = deputes_email(list)

  array_final = []

  if first.length == last.length
    first.length.times do |i|
    hash_of_name = {}
    hash_of_name["first name"] = first[i]
    hash_of_name['last name'] = last[i]
    # hash_of_name['email'] = emails[i]
      array_final << hash_of_name
    end 
  end

  return array_final
end

puts array_final(list)









def scrap_assemblee
  #Recupe site de l'assemblee
  doc = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/deputes/liste/tableau%22"))
  #preparation de l'array
  array_depute = []
  #On prend tout les liens "a" dans un objet "td"
  doc.xpath('//td/a').each do |node|

    #lobjet node text est sous format "M. xxx xxx" est divisé où [0] est M. ou Mme, [1] prenom, [2] nom
    prenom_depute = node.text.split(' ')[1]
    nom_depute = node.text.split(' ')[2]
    #On créer les liens à visiter
    link = "http://www2.assemblee-nationale.fr/" + node['href']
    page_depute = Nokogiri::HTML(URI.open(link)) #On ouvre le lien de chaque depute
    email_depute = page_depute.xpath("//li[text()='Mél : ']/a").text #On target la partie "li" qui contient comme texte "mél"

    #On a toute les infos qu'il nous faut, on créer donc le hash et on le rempli avant de le mettre dans l'array
    hash_depute = Hash.new
    hash_depute["first_name"] = prenom_depute
    hash_depute["last_name"] = nom_depute
    hash_depute["email"] = email_depute
    array_depute << hash_depute 

  end
  return array_depute
end

#Pour tester enlever commentaire
#puts scrap_assemblee