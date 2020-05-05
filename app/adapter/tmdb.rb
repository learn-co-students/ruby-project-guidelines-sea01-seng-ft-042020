class Tmdb
    def self.get_data(keyword)
        url = "https://api.themoviedb.org/3/search/movie?api_key=7b6144ac23b77c8eaa46c432f40be04e&language=en-US&query=#{keyword}&page=1&include_adult=false"
        response = RestClient.get(url)
        response_body = response.body
        json_response = JSON.parse(response_body)
        movies = json_response["results"].map do |movie|
            {title: movie["title"]}
        end
        # binding.pry
    end
    # binding.pry
end