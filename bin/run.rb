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
def user_options(cli)
    cli.space 
    cli.list_user_options
    user_input = gets.chomp.to_i

    case user_input
        when 1
        #option1 - movies
        #Prompts user to find movie in database
        cli.space
        puts "What movie are you looking for?"
        user_input = gets.strip
        cli.movie = cli.find_movie(user_input)
        #output movie info: title, desc
        puts cli.movie[:title]
        #give option to write/read review, or go back to user_options
        puts "\n"
        puts "Please select from the following"
        puts "\n"
        puts "1. Write a review"
        puts "\n"
        puts "2. Read reviews"
        puts "\n"
        puts "3. Return to main menu"
        puts "\n"
        user_input = gets.chomp.to_i
            case user_input
                when 1
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    puts "Write your review:"
                    write_up = gets.chomp
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    puts "Now rate this movie from 1 to 5:"
                    rating = gets.chomp.to_i.clamp(1, 5)
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    cli.write_review(write_up, rating)
                    user_options(cli)
                when 2
                    puts cli.read_reviews
                    user_options(cli)
                when 3
                    user_options(cli)
                end
        when 2
            #option 2 - user settings
            #update/delete account -or- logout, should send back to user account prompt
            puts "\n"
            puts "\n"
            puts "\n"
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
            user_input = gets.chomp.to_i
            case user_input
                when 1 #update account
                    cli.update_account(cli.user.name)
                    user_options(cli)
                when 2 #delete account
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    user = User.find_user(cli.user.name)
                    # binding.pry
                    user.destroy
                    puts "Account successfully deleted! Goodbye!"
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    
                when 3 #update review
                    #finds a users reviews
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    puts "Please select a review:"
                    puts "\n"
                    reviews = cli.user.find_reviews
                    puts "\n"
                    puts "\n"
                    puts "\n"

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
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    puts "Here's your updated review!"
                    puts "\n"
                    puts "#{selected_review.movie.title} --- #{rating} --- #{write_up}"
                    user_options(cli)

                when 4 #delete a review
                    #finds a users reviews
                    puts "\n"
                    puts "\n"
                    puts "\n"
                    reviews = cli.user.find_reviews
                    puts "\n"
                    puts "\n"
                    puts "\n"

                    #prompts user to pick one of their reviews
                    puts "Please select a review"
                    user_input = gets.chomp.to_i
                    puts "\n"
                    puts "\n"
                    puts "\n"

                    #stores selected review in a var
                    selected_review = reviews[(user_input)-1]
                    
                    #deletes selected review
                    selected_review.destroy
                    puts "You have deleted your review!"

                    user_options(cli)
                when 5 
                    #return to main menu
                    user_options(cli)
            end

        when 3
            #exit user_options function/program
            puts "\n"
            puts "\n"
            puts "\n"
            puts "Thanks for using MovieBook! Goodbye!"
            puts "\n"
            puts "\n"
            puts "\n"
    end
end

account_prompt(cli)
user_options(cli)

# binding.pry
