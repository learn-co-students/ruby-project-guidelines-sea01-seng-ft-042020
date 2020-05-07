require 'pry'
class Movie < ActiveRecord::Base

    has_many :reviews
    has_many :users, through: :reviews

    def self.search_movie_database(user_input)
    # requesting array from api using user_input as the search query
        search_results = Tmdb.get_data(user_input).uniq
        unless search_results == []
        # formatting search_results into numbered list for user
            search_list = search_results.map do |result|
            "#{(search_results.index(result)) + 1}. #{result[:title]}"
            end
            puts "\n"
            puts "\n"
            puts "\n"
            puts search_list
            puts "\n"
            puts "\n"
            puts "\n"
            puts "See anything you like? Input the number of the movie you want to view."
            user_input = gets.chomp.to_i.clamp(0, 30)
            # binding.pry
            movie_choice = search_results[(user_input)-1]
            movie = Movie.find_or_create_by(title: movie_choice[:title])
            puts "\n"
            puts "\n"
            puts "\n"
            movie
        else
            return
        end
    end

end