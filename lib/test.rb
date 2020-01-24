require 'open-uri'
require 'nokogiri'

def bonjour
  url = "http://annuaire-des-mairies.com/val-d-oise.html"
  puts "Ce programme va scrapper les emails des mairies du Val-d'Oise présentes sur le site : #{url}"
end

def scrap_townhalls
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  puts "Récupération des noms des townhalls ..."
  all_townhalls = page.xpath('//a[@class="lientxt"]')
  puts "Fin de la récupération des noms des townhalls."
  return all_townhalls
end

def townhalls_text(all_townhalls)
  puts "Récupération du texte de chaque mairie et implémentation dans un nouveau tableau"
  all_townhalls_text = []
  all_townhalls.each do |townhall|
    all_townhalls_text << townhall.text
  end
  all_townhalls_clean = all_townhalls_text
  print all_townhalls_clean
  return all_townhalls_clean
end

bonjour()
townhalls_text(scrap_townhalls())


def get_townhall_urls

end

def get_townhall_email(townhall_url)

end

get_townhall_email(get_townhall_urls)


begin
def scrap_emails
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  puts "Récupération des emails ..."
  all_emails = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  puts "Fin de la récupération des emails."
  return all_emails
end
def emails_text(all_emails)
  puts "Récupération du texte constituant les emails et implémentation dans un nouveau tableau"
  all_emails_text = []
  all_emails.each do |email|
    all_emails_text << email.text
  end
  return all_emails_text
end
def merge(all_townhalls_clean, all_emails_clean)
  puts "Fusion des tableaux des townhalls et des emails"
  hash = Hash[all_townhalls_clean.zip(all_emails_clean)]
  hash = hash.map {|townhall, email| {townhall => email}}
  print hash
  puts
end
def perform
  bonjour()
  merge(townhalls_text(scrap_townhalls),emails_text(scrap_emails))
end
perform
end
