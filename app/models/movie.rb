class Movie < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews

    def self.search_movie_database(keyword)
    # requesting array from api using 'keyword'(user input) as the search query
        search_results = Tmdb.get_data(keyword).uniq

    # formatting search_results into numbered list for user
        search_list = search_results.map do |result|
        "#{(search_results.index(result)) + 1}. #{result[:title]}"
        end
        puts search_list
        puts "See anything you like? Input the number of the movie you want to view."
        user_input = gets.chomp.to_i
        movie_choice = search_results[(user_input)-1]
        Movie.find_or_create_by(title: movie_choice[:title])
    end

end