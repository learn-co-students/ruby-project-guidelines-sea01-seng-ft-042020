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

    def greet_2
        puts "\n"
        puts "\n"
        puts "Seen anything good lately? Help our community figure out what to watch by leaving a review!"
        puts "\n"
        puts "\n"
    end

    def user_input_1
        puts "\n"
        puts "\n"
        puts "Search for a movie:"
        movie = gets.strip
        # puts movie
        search_results = Tmdb.get_data(movie).uniq
        # puts search_results
        search_list = search_results.map do |result|
            "#{(search_results.index(result)) + 1}. #{result[:title]}"
        end
        puts search_list
        puts "Pick your movie by typing its number!"
        

    end


end