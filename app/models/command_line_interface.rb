require 'pry'
class CommandLineInterface
    attr_accessor :user, :movie
    
    def initialize
    end



    # Greeting functions
        def greet
            self.space
            puts ".```````````````````````````````````````````````ydd/``````````````"
            puts ".```````````````````````````````````````````````+ss:``````````````"
            puts ".```://.-/oo+:.`:+oo+-````-/osoo/-`-++/.````-++//++-``:+sss+-`````"
            puts ".```hNNhdddmNNhhmhdNNm+`-ymNmddmNms:hNNo```.dNN+hNN+.ymNhyhNmy.```"
            puts ".```hNNm/.`/NNNh-..sNNd-dNNs-..-yNNh:mNm:``sNNs`hNM+sNNo...oNNo```"
            puts ".```hNNy```.mNNo```/MNd+NNm.````-NNN//NNd./NNh.`hNNodNNdhhhdNNh.``"
            puts ".```hNNy```.mNNo ``/NNd/NNN-````:NNm:`sNNydNm-``hNM+hNNo:--/+/:```"
            puts "..``hNNy```.mNNo ``/NNm-yNNd+::+dNNo```yNNNN/```hNM+/mNmo/+dmd:```"
            puts ".```hNNy```.dmN+```/Nmd../hmmmmmdy:````-hdds````sdd/`-shdddhs:````"
            puts "..``://:````-::.```.---````-:::-.```````...`````.-///:`.....``````"
            puts "..``yddd:````````````````````````````````````````-NNNs````````````"
            puts "..``hNNN/````````````````````````````````````````-NNNy ```````````"
            puts "..``hNNN/`.-::-.```````.:/++/:.``````.-+oooo+-.``-NNNy``./sss+.```"
            puts "`.``hNNNssdmNmmds-```/ydmNNNNmds:``.+hmNNmmNNmh/`-NNNy`-yNNmo.````"
            puts "`.``hNNNNdo+oyNNNm/.yNNNho//sdNNm+.sNNNy/--/hNNNo-NNNyomNNs-``````"
            puts "`.``hNNNy.````+NNNhoNNNs.````-dNNmsNNNs`````.dNNN:NNNNNNNm:```````"
            puts "`.``hNNN+`````.mNNmmNNN:``````yNNNdNNM/``````hNNN/NNNNdhNNm:````` "
            puts "`.``hNNNo`````-NNNmhNNNo`````.dNNmoNNNy.````:mNNd-NNNh..sNNN/```` "
            puts "`.``yNNNd:.``-yNNNs:mNNmo:--/hNNm+.sNNNho/+smNNh--NNNy``.sNNN+````"
            puts "`.``yNNNmmhyymNNms.`-ymNNNmmNNmh:``./ydmNNNNmh+.`-dddo```.ohhy:```"
            puts "`.``sddh:/shddyo-`````-/+ssso/-```````.::/::.`````...```````````` "
            puts "`.``...`````..``````````````````````````````````````````````````` "
            self.space
            puts "Loading..."
        end

        def greet_2
            puts "\n"
            puts "\n"
            puts "\n"
            puts "*********************"
            puts 'Welcome to MovieBook!'
            puts "*********************"
            puts "\n"
            puts "\n"
            puts "\n"
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
            puts "What movie are you looking for, #{cli.user.name}?"
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
            puts "\n"
            puts cli.movie[:release_date]
            puts "\n"
            puts cli.movie[:description]
            puts "\n"
            unless cli.movie.reviews == []
                puts "Average Rating: #{cli.movie.average_rating}"
            end
            self.space
            #give option to write/read review, or go back to main_menu
            cli.movie_options
        end

        def write_review(write_up, rating)
            review = Review.create(user_id: @user[:id], movie_id: @movie[:id], write_up: write_up, rating: rating)
            puts "Here is your review:"
            self.space
            puts "#{@movie[:title]} --- #{rating}/5 --- #{write_up}"
            self.space
            @user.reviews << review
        end

        def movie_menu_write_review(cli)
            puts "Write your review:"
            write_up = gets.chomp
            while write_up == ""
                system("clear")
                puts "\n"
                puts "Please...Say ANYTHING."
                puts "\n"
                write_up = gets.chomp
            end
            system("clear")
            puts "Now rate this movie from 1 to 5:"
            rating = gets.chomp.to_i
            while rating < 1 || rating > 5
                system("clear")
                puts "\n"
                puts "Invalid rating"
                puts "\n"
                puts "Rate this movie from 1 to 5:"
                puts "\n"
                rating = gets.chomp.to_i
            end
            system("clear")
            cli.write_review(write_up, rating)
            main_menu(cli)
        end

        def movie_menu_read_reviews
            self.space
            reviews = Review.where(movie_id: @movie[:id])
            if reviews == []
                puts "Sorry, looks like this one hasn't been reviewed yet"
            else
                puts @movie[:title]
                puts "\n"
                puts "Average Rating: #{@movie.average_rating}"
                puts "\n"
                reviews.map do |review|
                    puts "#{review[:rating]} --- #{review[:write_up]}"
                end
            end
        end

    
    
        
        
     # User Settings functions   
        def update_account(user_name)
            #Finds current instance of user
            user = User.find_user(user_name)
            self.space
            #prompts user for new name and stores in variable
            puts "Enter your new name:"
            user_input = gets.strip
            while user_input == ""
                puts "Please enter a valid name."
                puts "\n"
                puts "Example: Lightning McQueen"
                puts "\n"
                user_input = gets.strip
            end
    
            #puts in new name and stores in current user instance
            User.change_name(user, user_input)
            @user.name = user_input
            self.space
    
            #tells user name change successful
            puts "Your name has been changed to: #{user_input}"
            self.space
        end

        def delete_account(cli)
            user = User.find_user(cli.user.name)
            binding.pry
            user.destroy
            puts "Account successfully deleted!"
            self.space
        end

        def update_review(cli)
            #finds a user's reviews

            system("clear")
            puts "Here are your reviews:"
            puts "\n"
            reviews = cli.user.find_reviews
            if reviews == []
                puts "Looks like you don't have any reviews!"
                self.space
                main_menu(cli)
            end

            #prompts user to pick one of their reviews
            puts "\n"
            puts "Please enter the number for your corresponding selection:"
            user_input = gets.chomp.to_i
            while user_input.class != Integer
                system("clear")
                puts reviews
                puts "\n"
                puts "Please enter the number for your corresponding selection:"
                puts "\n"
                puts "Options: 1 - #{reviews.count}"
                puts "\n"
                user_input = gets.chomp.to_i
            end
            while user_input < 1 || user_input > reviews.size
                system("clear")
                puts reviews
                puts "\n"
                puts "Please enter the number for your corresponding selection"
                puts "\n"
                puts "Options: 1 - #{reviews.count}"
                puts "\n"
                user_input = gets.chomp.to_i
            end
            puts "\n"
            #stores selected review in a var
            selected_review = reviews[(user_input)-1]
            system("clear")
            #ask for new review and rating
            puts "Write your new review:"
            write_up = gets.chomp
            while write_up == ""
                system("clear")
                puts "\n"
                puts "Please enter a valid review"
                puts "\n"
                puts "Example: Phenomenal film! ;)"
                puts "\n"
                write_up = gets.chomp
            end
            system("clear")
            puts "Rate this movie from 1 to 5:"
            rating = gets.chomp.to_i
            while rating < 1 || rating > 5
                system("clear")
                puts "\n"
                puts "Rate this movie from 1 to 5:"
                puts "\n"
                rating = gets.chomp.to_i
            end
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
            if reviews == []
                system("clear")
                puts "Looks like you don't have any reviews!"
                self.space
                main_menu(cli)
            end

            #prompts user to pick one of their reviews
            puts "Please select a review to delete:"
            user_input = gets.chomp.to_i
            while user_input.class != Integer
                system("clear")
                puts cli.user.find_reviews
                puts "\n"
                puts "Please enter the number for your corresponding selection:"
                puts "\n"
                puts "Options: 1 - #{reviews.count}"
                puts "\n"
                user_input = gets.chomp.to_i
            end
            while user_input < 1 || user_input > reviews.size
                system("clear")
                puts cli.user.find_reviews
                puts "\n"
                puts "Please enter the number for your corresponding selection"
                puts "\n"
                puts "Options: 1 - #{reviews.count}"
                puts "\n"
                user_input = gets.chomp.to_i
            end
            cli.space

            #stores selected review in a var
            selected_review = reviews[(user_input)-1]
                    
            #deletes selected review
            selected_review.destroy
            puts "You have deleted your review!"
            cli.space

        end


   

    #Options prompts
        def main_menu_options
            puts "Please select from the following:"
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
            puts "Please select from the following:"
            puts "\n"
            puts "1. Write a review"
            puts "\n"
            puts "2. Read reviews"
            puts "\n"
            puts "3. Return to main menu"
            puts "\n"
        end

        def user_settings_options
            puts "Please select from the following:"
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

        def delete_account_prompt
            puts "Please select from the following:"
            puts "\n"
            puts "1. Exit MovieBook"
            puts "\n"
            puts "2. Find or create a different account"
            puts "\n"
        end

        def goodbye_message
            system("clear")
            self.space
            puts "Thanks for using MovieBook, #{self.user.name}! Goodbye!"
            self.space
            self.credit
            self.space
            sleep(3)
        end



    #Auxiliary functions
        def space
            puts "\n"
            puts "\n"
            puts "\n"
        end

        def credit
            puts ":::::::///`   ////-    `////-   .///////:-`     .++++++//-       `-/+++++++++ooooooooooooo+/-  "
            puts "```.::-```    //://.   :/://-   .//-``.-://:    .++-```/++`     -++++++++++++oooooooooooooooo+."
            puts "   `::.       //:.//` -/:.//-   .//-     -/+-   .++/:::+/-     `+++++++++++++ooooooooooooooooo+"
            puts "   `::.       //: -/:.//``//-   .//-     -/+-   .++/---/+/.    `+++++++++++++ooooooooooooooooo+"
            puts "   `::.       //:  :///. `//-   .//-``..://:    .++:```.++/     -++++++++++++oooooooooooooooo+."
            puts "   `::.       //:  `//-  `//-   .///////:-`     .+++++++/-`      `-:+++++++++ooooooooooooo+/-  "
            self.space
            puts "This product uses the TMDb API but is not endorsed or certified by TMDb."
        end



end