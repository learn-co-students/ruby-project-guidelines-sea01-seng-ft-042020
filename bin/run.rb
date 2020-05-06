require './config/environment'

#creates new instance of CommandLineInterface
cli = CommandLineInterface.new

#Welcomes user to MovieBook
cli.greet

#User account prompt - prompts user to find or create their account
puts "Enter your name to find your account or create a new one!"
user_input = gets.strip
cli.user = cli.user_account(user_input)

#Gives user list of options
def user_options(cli)
    cli.list_user_options
    user_input = gets.chomp.to_i

    case user_input
        when 1
        #option1 - movies
        #Prompts user to find movie in database
        puts "What movie are you looking for?"
        user_input = gets.strip
        cli.movie = cli.find_movie(user_input)
        #output movie info: title, desc
        puts cli.movie[:title]
        #give option to write/read review, or go back to user_options
        puts "Please select from the following"
        puts "\n"
        puts "1. Write a review"
        puts "2. Read a review"
        puts "3. Return to main menu"
        user_input = gets.chomp.to_i
            case user_input
                when 1
                    puts "Write your review"
                    write_up = gets.chomp
                    puts "Now rate this movie from 1 to 5"
                    rating = gets.chomp.to_i.clamp(1, 5)
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
            puts "Please select from the following"
            puts "\n"
            puts "1. Update account"
            puts "2. Delete account"
            puts "3. Update a review"
            puts "4. Delete a review"
            puts "5. Return to main menu"
            user_input = gets.chomp.to_i
            case user_input
                when 1
                    #update account
                    cli.update_account
                when 2
                    #delete account
                when 3
                    #update a review
                when 4
                    #delete a review
                when 5 
                    #return to main menu
                    user_options(cli)
            end

        when 3
            #exit user_options function/program
    end
end

user_options(cli)

# binding.pry
