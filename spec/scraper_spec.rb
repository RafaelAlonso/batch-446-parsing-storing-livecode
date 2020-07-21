require_relative '../main'

describe "#fetch_movies_url" do
  it "deveria ter tal comportamento" do
    urls_do_metodo = fetch_movies_url

    expected_urls = [
      "http://www.imdb.com/title/tt0111161/",
      "http://www.imdb.com/title/tt0068646/",
      "http://www.imdb.com/title/tt0071562/",
      "http://www.imdb.com/title/tt0468569/",
      "http://www.imdb.com/title/tt0050083/"
    ]

    # urls_do_metodo == expected_urls
    expect(urls_do_metodo).to eq(expected_urls)
  end
end

describe "#fetch_movie_info" do
  it "deve recuperar informações sobre um filme" do
    infos_do_filme = fetch_movie_info("http://www.imdb.com/title/tt0111161/")

    expected_info = {
      cast: ["Tim Robbins", "Morgan Freeman", "Bob Gunton"],
      director: "Frank Darabont",
      storyline: "Chronicles the experiences of a formerly successful banker as a prisoner in the gloomy jailhouse of Shawshank after being found guilty of a crime he did not commit. The film portrays the man's unique way of dealing with his new, torturous life; along the way he befriends a number of fellow prisoners, most notably a wise long-term inmate named Red.",
      title: "The Shawshank Redemption",
      year: 1994
    }

    expect(infos_do_filme).to eq(expected_info)
  end
end