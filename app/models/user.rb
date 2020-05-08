class User < ActiveRecord::Base
    has_many :reviews
    has_many :movies, through: :reviews

    def find_reviews
        reviews = Review.where(user_id: self.id)
        reviews.map do |review|
           puts "#{(reviews.index(review)) + 1}. #{review.movie.title} --- #{review.rating} --- #{review.write_up}"
        end
        reviews
    end

    def self.find_user(name)
        user = User.find_by(name: name)
        user
    end

    def self.change_name(user, new_name)
        user.update(name: new_name)
        user.save
    end

end