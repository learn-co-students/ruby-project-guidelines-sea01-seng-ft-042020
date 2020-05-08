require './config/environment'
require 'pry'


#creates new instance of CommandLineInterface
cli = CommandLineInterface.new
system("clear")

#Welcomes user to MovieBook
cli.greet
sleep(3)
system("clear")
#User account prompt - prompts user to find or create their account
def account_prompt(cli)
    cli.greet_2
    puts "Enter your name to find your account or create a new one!"
    user_input = gets.strip
    if user_input == ""
        puts "Hmm, I didn't quite catch that. Please enter a valid name."
        account_prompt(cli)
    end
    cli.user = cli.user_account(user_input)
end


#Gives user list of options
def main_menu(cli)
    cli.main_menu_options
    user_input = gets.chomp.to_i

    case user_input #Main Menu
        when 1 #Movie Menu
            system("clear")
            cli.movie_menu(cli)
            user_input = gets.chomp.to_i
            case user_input #Menu for selected movie
                when 1 #write new review 
                    system("clear")
                    cli.movie_menu_write_review(cli)
                when 2 #read reviews 
                    system("clear")
                    puts cli.movie_menu_read_reviews
                    main_menu(cli)
                when 3 #exit to main menu
                    system("clear")
                    main_menu(cli)
            end
        when 2 #User Settings Menu
            #update/delete account -or- logout, should send back to user account prompt
            system("clear")
            cli.user_settings_options
            user_input = gets.chomp.to_i
            case user_input
                when 1 #update account
                    cli.update_account(cli.user.name)
                    main_menu(cli)
                when 2 #delete account
                    system("clear")
                    cli.delete_account(cli)
                    cli.space
                    cli.delete_account_prompt
                    user_input = gets.chomp.to_i
                    case user_input #Stay or leave MovieBook
                    when 1 #exit MovieBook
                        cli.goodbye_message
                    when 2 #start from find or create user account
                        system("clear")
                        application(cli)
                    end
                when 3 #update review
                    system("clear")
                    cli.update_review(cli)
                    main_menu(cli)
                when 4 #delete a review
                    #finds a users reviews
                    system("clear")
                    cli.delete_review(cli)
                    main_menu(cli)
                when 5 #return to main menu
                    system("clear")
                    main_menu(cli)
            end

        when 3 #Exit
            cli.goodbye_message
        else
            system("clear")
            puts "Sorry, that isn't one of our options. Please select 1, 2, or 3"
            cli.space
            main_menu(cli)
        end
end

def application(cli)
    account_prompt(cli)
    system("clear")
    main_menu(cli)
end
application(cli)
system("clear")
# binding.pry
