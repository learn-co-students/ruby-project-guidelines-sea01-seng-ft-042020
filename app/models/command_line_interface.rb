class CommandLineInterface
    attr_accessor :user, :movie
    
    def initialize
    end

    def space
        puts "\n"
        puts "\n"
        puts "\n"
    end

    # Greets the user upon opening MovieBook
    def greet
        self.space
        puts "*********************"
        puts 'Welcome to MovieBook!'
        puts "*********************"
        self.space
    end


    def user_account(answer)
        # self.find_or_create_user_account(answer)
        User.find_or_create_by(name: answer)
    end

    def find_movie(answer)
        Movie.search_movie_database(answer)
    end

   

    def write_review(write_up, rating)
        review = Review.create(user_id: @user[:id], movie_id: @movie[:id], write_up: write_up, rating: rating)
        puts "#{@movie[:title]} --- #{rating}/5 --- #{write_up}"
        @user.reviews << review
    end

    def movie_menu_read_reviews
        self.space
        puts @movie[:title]
        puts "\n"
        Review.where(movie_id: @movie[:id]).map do |review|
            puts "#{review[:rating]} --- #{review[:write_up]}"
        end
    end




    def movie_menu_write_review(cli)
        cli.space
        puts "Write your review:"
        write_up = gets.chomp
        cli.space
        puts "Now rate this movie from 1 to 5:"
        rating = gets.chomp.to_i.clamp(1, 5)
        cli.space
        cli.write_review(write_up, rating)
        main_menu(cli)
    end

   

    #options prompts
    def main_menu_options
        puts "Please select from the following"
        puts "\n"
        puts "1. Movies: info, reviews"
        puts "\n"
        puts "2. User Settings"
        puts "\n"
        puts "3. Exit"
        puts "\n"
    end

    def movie_options
        puts "\n"
        puts "Please select from the following"
        puts "\n"
        puts "1. Write a review"
        puts "\n"
        puts "2. Read reviews"
        puts "\n"
        puts "3. Return to main menu"
        puts "\n"
    end

    def user_settings_options
        puts "Please select from the following"
        puts "\n"
        puts "1. Update account"
        puts "\n"
        puts "2. Delete account"
        puts "\n"
        puts "3. Update a review"
        puts "\n"
        puts "4. Delete a review"
        puts "\n"
        puts "5. Return to main menu"
        puts "\n"
    end

    
    def update_account(user_name)
        #Finds current instance of user
        user = User.find_user(user_name)
        self.space
        #prompts user for new name and stores in variable
        puts "Enter your new name:"
        user_input = gets.strip

        #puts in new name and stores in current user instance
        User.change_name(user, user_input)
        self.space

        #tells user name change successful
        puts "Your name has been changed to: #{user_input}"
    end


 













end