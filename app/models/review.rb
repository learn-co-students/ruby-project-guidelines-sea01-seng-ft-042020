require 'pry'
class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :movie

    def self.update_review(review, rating, write_up)
        review.update(rating: rating, write_up: write_up)
    end
end