class CommandLineInterface
    attr_accessor :user, :movie
    
    def initialize
    end



    # Greeting functions
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



    # Movie functions
        def find_movie(user_input)
            Movie.search_movie_database(user_input)
        end

        def movie_menu(cli)
            #Prompts user to find movie in database
            puts "What movie are you looking for?"
            user_input = gets.strip
            if user_input == ""
                system("clear")
                puts "Please enter a valid request."
                puts "\n"
                puts "Example: Cars 4"
                puts "\n"
                movie_menu(cli)
            end
            cli.movie = cli.find_movie(user_input)
            if cli.movie == nil
                puts "\n"
                puts "Sorry, we couldn't find that one. Please try again."
                puts "\n"
                movie_menu(cli)
            end
            system("clear")
            # output movie info: title, desc
            puts cli.movie[:title]
            #give option to write/read review, or go back to main_menu
            cli.movie_options
        end

        def write_review(write_up, rating)
            review = Review.create(user_id: @user[:id], movie_id: @movie[:id], write_up: write_up, rating: rating)
            puts "Here is your review:"
            puts "#{@movie[:title]} --- #{rating}/5 --- #{write_up}"
            self.space
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
            puts "Write your review:"
            write_up = gets.chomp
            if write_up == ""
                puts "Please...Say ANYTHING."
                puts "\n"
                movie_menu_write_review(cli)
            end
            system("clear")
            puts "Now rate this movie from 1 to 5:"
            rating = gets.chomp.to_i.clamp(1, 5)
            system("clear")
            cli.write_review(write_up, rating)
            main_menu(cli)
        end
    
    
        
        
     # User Settings functions   
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

        def delete_account(cli)
            user = User.find_user(cli.user.name)
            user.destroy
            puts "Account successfully deleted! Goodbye!"
        end

        def update_review(cli)
            #finds a user's reviews
            puts "Here are your reviews:"
            puts "\n"
            reviews = cli.user.find_reviews
            # system("clear")

            #prompts user to pick one of their reviews
            puts "\n"
            puts "Please select a review to update:"
            user_input = gets.chomp.to_i
            puts "\n"
            #stores selected review in a var
            selected_review = reviews[(user_input)-1]
            system("clear")
            #ask for new review and rating
            puts "Write your new review:"
            write_up = gets.chomp
            system("clear")
            puts "Now rate this movie from 1 to 5:"
            rating = gets.chomp.to_i.clamp(1, 5)
            Review.update_review(selected_review, rating, write_up)
            system("clear")
            puts "Here's your updated review!"
            puts "\n"
            puts "#{selected_review.movie.title} --- #{rating} --- #{write_up}"
            cli.space
        end

        def delete_review(cli)
            #finds a users reviews
            puts "Here are your reviews:"
            puts "\n"
            reviews = cli.user.find_reviews
            cli.space

            #prompts user to pick one of their reviews
            puts "Please select a review to delete:"
            user_input = gets.chomp.to_i
            cli.space

            #stores selected review in a var
            selected_review = reviews[(user_input)-1]
                    
            #deletes selected review
            selected_review.destroy
            puts "You have deleted your review!"
            cli.space

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

    


    #Auxiliary functions
        def space
            puts "\n"
            puts "\n"
            puts "\n"
        end












end