class CommandLineInterface

    def initialize

    end

    def greet
        puts "\n"
        puts "\n"
        puts "\n"
        puts "***********************************"
        puts 'Welcome to MovieBook!'
        puts "***********************************"
        puts "\n"
        puts "\n"
        puts "\n"
    end

    def user_account
        current_user = self.find_or_create_user_account(user_input)
        current_user
    end

    def find_movie
        puts "What movie are you looking for?"
        user_input = gets.strip
        Movie.search_movie_database(user_input)
    end

    def review_prompt
        puts "Would you like to read a review or write a new review?"
        puts "1. Write"
        puts "2. Read" 
    end

    def write_review
        Review.create(user_id: current_user[:id], movie_id: current_movie[:id], write_up: write_up, rating: rating)
    end

    def read_reviews
        Review.where(movie_id: current_movie[:id])
    end

    def user_input_1
        puts "\n"
        puts "\n"
        puts "Search for a movie:"
        movie = gets.strip
        # puts movie
        puts search_list
        puts "Pick your movie by typing its number!"
    end
    
    
















    # output the movie the user has searched for
    
    # # CREATE
    # create user account
    def find_or_create_user_account(name)
        User.find_or_create_by(name: name)
    end
    # create review/leave rating connected to user instance and movie instance
    def create_review(rating, write_up)
        Review.create(rating: rating, write_up: write_up)
    end
    
    # # READ
    # find a movie
    def search_movie_database(keyword)
    # requesting array from api using 'keyword'(user input) as the search query
        search_results = Tmdb.get_data(keyword).uniq

    # formatting search_results into numbered list for user
        search_list = search_results.map do |result|
        "#{(search_results.index(result)) + 1}. #{result[:title]}"
        end
        puts search_list
        puts "See anything you like? Input the number of the movie you want to view."
        user_input = gets.strip
        movie_choice = search_results[(user_input)-1]
        Movie.find_or_create_by(title: movie_choice[:title])
    end

    # def create_movie_in_our_database(movie)
    #     movie_object = Tmdb.get_data(movie).uniq
    #     Movie.create(movie_object)
        
    # end

    # find other reviews
    def find_reviews_by_movie(movie)
        Review.where(movie_id: movie.id)
    end
    
    # # UPDATE
    # update user review 
    # update user name

    # # DESTROY
    # delete account
    # delete review






end