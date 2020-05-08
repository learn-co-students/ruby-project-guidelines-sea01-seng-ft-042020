Movie.destroy_all

movies = Tmdb.get_data("furious")
movies.each do |movie|
    Movie.create(movie)
end
puts "done!"