class User < ActiveRecord::Base
    has_many :reviews
    has_many :movies, through: :reviews


    # CREATE
    def create_review(movie, rating, write_up)
        Review.create(movie_id: movie.id, user_id: self.id, rating: rating, write_up: write_up)
    end

    def self.change_name(user, new_name)
        user.update(name: new_name)
    end
end