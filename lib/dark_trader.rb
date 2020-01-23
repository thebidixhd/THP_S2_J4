require 'open-uri'
require 'nokogiri'

def scrap_symbols
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  puts "Récupération des symboles sur le site"
  all_cryptos_symbols = page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody//tr/td[3]/div')
   puts "Fin de la récupération des symboles."
  return all_cryptos_symbols
end

def scrap_price
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  puts "Récupération des prix sur le site"
  all_cryptos_prices = page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody//tr/td[5]/a')
  puts "Fin de la récupération des prix."
  return all_cryptos_prices
end

def symbols_text(all_cryptos_symbols)
  puts "Récupération du texte de chaque symboles et implémentation dans un nouveau tableau"
  all_cryptos_symbols_text = []
  all_cryptos_symbols.each do |crypto_symbol|
    all_cryptos_symbols_text << crypto_symbol.text
  end
  all_cryptos_symbols_clean = all_cryptos_symbols_text
  return all_cryptos_symbols_clean
end

def prices_text(all_cryptos_prices)
  puts "Récupération du texte et suppression des '$' de chaque prix et implémentation dans un nouveau tableau"
  all_cryptos_prices_text = []
  all_cryptos_prices.each do |crypto_price|
    all_cryptos_prices_text << crypto_price.text
  end
  return all_cryptos_prices_text
end

def prices_without_dollars_tof(all_cryptos_prices_text)
  all_cryptos_prices_text_without_dollars = []
  all_cryptos_prices_text.each do |crypto|
    all_cryptos_prices_text_without_dollars << crypto.delete("$").to_f
  end
  all_cryptos_prices_clean = all_cryptos_prices_text_without_dollars
  return all_cryptos_prices_clean
end


def merge(all_cryptos_symbols_clean, all_cryptos_prices_clean)
  puts "Fusion des tableaux symboles et des prix"
  hash = Hash[all_cryptos_symbols_clean.zip(all_cryptos_prices_clean)]
  hash = hash.map {|symbol, crypto| {symbol => crypto}}
  print hash
  puts
end

def perform
  merge(symbols_text(scrap_symbols),prices_without_dollars_tof(prices_text(scrap_price)))
end

perform
