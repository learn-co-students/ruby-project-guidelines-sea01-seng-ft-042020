class User < ActiveRecord::Base
    has_many :reviews
    has_many :movies, through: :reviews


    # CREATE
    def create_review(movie, rating, write_up)
        Review.create(movie_id: movie.id, user_id: self.id, rating: rating, write_up: write_up)
    end

    def find_reviews
        reviews = Review.where(user_id: self.id)
        reviews.map do |review|
           puts "#{(reviews.index(review)) + 1}. #{review.movie.title} --- #{review.rating} --- #{review.write_up}"
        end
        reviews
    end

    def self.find_user(name)
        User.find_by(name: name)
    end

    def self.change_name(user, new_name)
        user.update(name: new_name)
    end

end