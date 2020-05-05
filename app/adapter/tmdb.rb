# require './.env'

class Tmdb
    def self.get_data(keyword)
        key = ENV["TMDB_API_KEY"]
        # binding.pry
        url = "https://api.themoviedb.org/3/search/movie?api_key=#{key}&language=en-US&query=#{keyword}&page=1&include_adult=false"
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