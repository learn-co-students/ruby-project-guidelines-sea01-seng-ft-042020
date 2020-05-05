class User < ActiveRecord::Base
    has_many :reviews
    has_many :movies, through: :reviews


    def find_movie(keyword)
        movies = Tmdb.get_data("furious")
        movies.each do |movie|
        Movie.create(movie)
        end
    end
end