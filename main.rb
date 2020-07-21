#Dar um require das bibliotecas necessárias
require 'nokogiri'
require 'open-uri'
require 'yaml'
#Criar uma variável com o item que quero pesquisar na URL

def fetch_movies_url
  #Criar uma segunda variável com URL 
  url = "https://www.imdb.com/chart/top"

  #Ler a URL(acessar a página)
  url_info = open(url).read

  #Transformar o que conseguimos (info) em objeto de Ruby
  url_doc = Nokogiri::HTML(url_info)

  #Buscar informação necessária
  #descobrir a classe ou id do elemento no html
  lista = url_doc.search('.titleColumn a')

  
  #pegar os 5 primeiros
  elem_list = []

  lista.first(5).each do |elem|
    #Guardar info selecionada
    elem_list << "http://www.imdb.com#{elem.attribute('href').value}"
  
  end
  #Retornar info armazenada
  elem_list
end

def fetch_movie_info(url)
  url_other = open(url).read
  url_doc = Nokogiri::HTML(url_other)
  title_doc = url_doc.search('.title_wrapper h1').text.strip
  title = title_doc[0..-8]

  year_doc = url_doc.search('#titleYear a').text.strip
  # puts year_doc

  director_doc = url_doc.search('.credit_summary_item a').first.text.strip
  # puts director_doc

  cast_doc = url_doc.search('.credit_summary_item a')[-4..-2]
  cast = []
  cast_doc.each do |elem|
    cast << elem.text.strip
  end
  # p cast

  storyline_doc = url_doc.search('.inline.canwrap p span').text.strip
  # puts storyline_doc

  movie = {
    title: title,
    year: year_doc.to_i,
    director: director_doc,
    cast: cast,
    storyline: storyline_doc
  }

  return movie

end

# pego a url dos 5 filmes mais famosos do imdb
top_five_urls = fetch_movies_url

# crio uma array para guardar infos sobre os 5 filmes
top_five_movies = []

# para cada url que tenho
top_five_urls.each do |url|
  # recupero infos do filme com aquela url
  movie_info = fetch_movie_info(url)

  # jogo as infos obtidas pra dentro da array
  top_five_movies << movie_info
end

# Arquivo -> string -> Obj (parsing)
# Obj -> String -> Arquivo (storing)

File.open('movies.yml', 'w') do |f|
  f.write(top_five_movies.to_yaml)
end