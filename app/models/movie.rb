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
            puts "Please enter the number for your corresponding selection:"
            puts "\n"
            puts "Options: 1 - #{search_results.count}"
            user_input = gets.chomp.to_i
            while user_input.class != Integer
                system("clear")
                puts search_list
                puts "\n"
                puts "Please enter the number for your corresponding selection:"
                puts "\n"
                puts "Options: 1 - #{search_results.count}"
                puts "\n"
                user_input = gets.chomp.to_i
            end
            while user_input < 1 || user_input > search_results.size
                system("clear")
                puts search_list
                puts "\n"
                puts "Please enter the number for your corresponding selection"
                puts "\n"
                puts "Options: 1 - #{search_results.count}"
                puts "\n"
                user_input = gets.chomp.to_i
            end
            movie_choice = search_results[(user_input)-1]
            movie = Movie.find_or_create_by(title: movie_choice[:title], description: movie_choice[:description], release_date: movie_choice[:release_date])
            puts "\n"
            puts "\n"
            puts "\n"
            movie
        else
            return
        end
    end

    def average_rating
        reviews = Review.where(movie_id: self.id)
        review_ratings = reviews.map {|review| review.rating}
        average_rating = (review_ratings.reduce {|acc, ele| acc + ele}).to_f / reviews.size
    end

end