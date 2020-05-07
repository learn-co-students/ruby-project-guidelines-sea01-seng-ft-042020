require './config/environment'
require 'pry'


#creates new instance of CommandLineInterface
cli = CommandLineInterface.new

#Welcomes user to MovieBook
cli.greet

#User account prompt - prompts user to find or create their account
def account_prompt(cli)
    puts "Enter your name to find your account or create a new one!"
    user_input = gets.strip
    cli.user = cli.user_account(user_input)
end

#Gives user list of options
def main_menu(cli)
    cli.space 
    cli.main_menu_options
    user_input = gets.chomp.to_i

    case user_input
        when 1 #Movie Menu
            #Prompts user to find movie in database
            cli.space
            puts "What movie are you looking for?"
            user_input = gets.strip
            cli.movie = cli.find_movie(user_input)

            #output movie info: title, desc
            puts cli.movie[:title]

            #give option to write/read review, or go back to main_menu
            cli.movie_options
            user_input = gets.chomp.to_i

            case user_input
                when 1 #write new review 
                    cli.movie_menu_write_review(cli)
                when 2 #read reviews 
                    puts cli.movie_menu_read_reviews
                    main_menu(cli)
                when 3 #exit to main menu
                    main_menu(cli)
            end
        when 2
            #option 2 - User Settings Menu
            #update/delete account -or- logout, should send back to user account prompt
            cli.space
            cli.user_settings_options
            user_input = gets.chomp.to_i
            case user_input
                when 1 #update account
                    cli.update_account(cli.user.name)
                    main_menu(cli)
                when 2 #delete account
                    cli.space
                    user = User.find_user(cli.user.name)
                    # binding.pry
                    user.destroy
                    puts "Account successfully deleted! Goodbye!"
                    cli.space
                    
                when 3 #update review
                    #finds a users reviews
                    cli.space
                    puts "Please select a review:"
                    puts "\n"
                    reviews = cli.user.find_reviews
                    cli.space

                    #prompts user to pick one of their reviews
                    user_input = gets.chomp.to_i
                    puts "\n"
                    #stores selected review in a var
                    selected_review = reviews[(user_input)-1]
                    #ask for new review and rating
                    puts "Write your review:"
                    write_up = gets.chomp
                    puts "\n"
                    puts "Now rate this movie from 1 to 5:"
                    rating = gets.chomp.to_i.clamp(1, 5)
                    Review.update_review(selected_review, rating, write_up)
                    cli.space
                    puts "Here's your updated review!"
                    puts "\n"
                    puts "#{selected_review.movie.title} --- #{rating} --- #{write_up}"
                    main_menu(cli)

                when 4 #delete a review
                    #finds a users reviews
                    cli.space
                    reviews = cli.user.find_reviews
                    cli.space

                    #prompts user to pick one of their reviews
                    puts "Please select a review"
                    user_input = gets.chomp.to_i
                    cli.space

                    #stores selected review in a var
                    selected_review = reviews[(user_input)-1]
                    
                    #deletes selected review
                    selected_review.destroy
                    puts "You have deleted your review!"

                    main_menu(cli)
                when 5 #return to main menu
                    
                    main_menu(cli)
            end

        when 3 #exit main_menu function/program
            cli.space
            puts "Thanks for using MovieBook! Goodbye!"
            cli.space
    end
end

account_prompt(cli)
main_menu(cli)

# binding.pry
