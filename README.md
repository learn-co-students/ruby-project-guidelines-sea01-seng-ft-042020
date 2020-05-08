# MovieBook CLI App 🍿
Welcome to the MovieBook repo! 
## Objectives
- Learn about MovieBook
- Install MovieBook onto your local computer
- Obtain and install a TMDb API key
- Get started on MovieBook
## What is MovieBook?
MovieBook is a command line application that allows you (and those that share your computer) to write honest movie reviews. MovieBook allows users to share their reviews about a movie without feeling like they are being judged on their opinion or scolded for "giving away" the plotline. MovieBook uses the TMDb database to obtain movie information. This will give you access to a large selection of movies!
## Install MovieBook
To install MovieBook on to your local computer, please fork and clone this repository.
Got the repository? Awesome! Now, let's get your terminal working with the right `gems`. Run the command `bundle install` into your terminal. Great! You have all the `gems`, you're one step closer to getting started with MovieBook!
## TMDb API key
MovieBook uses the TMDb database to gather all the movies you would like to review. In order to use MovieBook, you must have a TMDb account and obtain an API key. 
**Instructions to obtain API key:**
1. To start, please create an account with TMDb [*here*](https://www.themoviedb.org/?language=en-US)
2. Go to your account settings
3. Select API on the lefthand sidebar
4. Select "click here" under Request an API key and follow the prompts to register
5. Once you are finished registering, go back to account settings
6. Select API on the lefthand sidebar
7. Find your API key "API Key (v3 auth)" and copy that key
Hooray, you got the key! Open up the MovieBook repository on your local computer and follow the instructions on how to enter your API key.
**Instructions to enter API key in MovieBook**
1. Open the `./app/adapter/tmdb.rb` file 
2. Find the `key` variable
3. Replace `ENV["TMDB_API_KEY"]` assigned to `key` with your copied API key
It should look like this:
```ruby
class Tmdb
    def self.get_data(keyword)
        key = ENV["TMDB_API_KEY"]   #<--- YOUR API KEY GOES HERE
        url = "https://api.themoviedb.org/3/search/movie?api_key=#{key}&language=en-US&query=#{keyword}&page=1&include_adult=false"
        response = RestClient.get(url)
        response_body = response.body
        json_response = JSON.parse(response_body)
        movies = json_response["results"].map do |movie|
            {title: movie["title"]}
        end
    en
end
```
You're all set with TMDb's API key and now have all the movies to search on your local computer. Let's start using MovieBook!
## Getting started with MovieBook
To get the program started, run the command `ruby bin/run.rb` in your terminal.
You should see our loading screen followed by the welcome message:
```ruby
*********************
Welcome to MovieBook!
*********************
```
You should be prompted to find or create an account. Give it a shot and enter a name!
After you've successfully created an account. You should be sent to our main menu.
**Main Menu**
The Main Menu lists all the options you are able to do. Continue reading this ReadMe for specific details on each option.
Here's what the Main Menu option looks like:
```ruby
Please select from the following:
1. Movies: info, reviews
2. User Settings
3. Exit
```
**Movies**
In Movies you are able to find a movie and read its description. Follow the prompts to help you search for a movie. Then choose to either write a review or read all the reviews about the movie. MovieBook will guide you through the process, so follow the prompts to help you finish your review.
Here's what the Movie Menu options looks like:
```ruby
Please select from the following:
1. Write a review
2. Read a review
3. Return to main menu
```
**User Settings**
In User Settings, you will find all options regarding your account and previous reviews. If you'd like to change your account name, choose *Update account*. If you'd like to delete your account, choose, *Delete account*. BE CAREFUL, you will not be able to undo this action once it is executed! If you already have a review and would like to update or delete that review choose the corresponding *Update a review* or *delete a review* option. To return to the Main Menu, choose *Return to main menu*.
Here's what the User Settings options look like:
```ruby
Please select from the following:
1. Update account
2. Delete account
3. Update a review
4. Delete a review
5. Return to main menu
```
**Exit** 
This option will end the MovieBook application. This product uses the TMdb API but is not endorsed or certified by TMdb.
Thank you for considering MovieBook and hope you enjoy! 😄