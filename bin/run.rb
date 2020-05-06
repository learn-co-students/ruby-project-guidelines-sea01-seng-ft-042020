require './config/environment'

#creates new instance of CommandLineInterface
cli = CommandLineInterface.new

#Welcomes user to MovieBook
cli.greet

#Prompts user to find or create their account
puts "Enter your name to find your account or create a new one!"
user_input = gets.strip
cli.user = cli.user_account(user_input)

#Prompts user to find movie in database
puts "What movie are you looking for?"
user_input = gets.strip
cli.movie = cli.find_movie(user_input)

#Prompts user to choose between reading or writing a review
cli.review_prompt
user_input = gets.chomp.to_i

if user_input == 1
    puts "Write your review"
    write_up = gets.chomp
    puts "Now rate this movie from 1 to 5"
    rating = gets.chomp.to_i.clamp(1, 5)
    cli.write_review(write_up, rating)

elsif user_input == 2
    cli.read_reviews
end



# Movie.search_movie_database("Spiderman")
# binding.pry
