class CreateReviews < ActiveRecord::Migration[5.2]

    def change
        create_table :reviews do |c|
            c.integer :user_id
            c.integer :movie_id
            c.integer :rating
            c.text :write_up
        end
    end
end