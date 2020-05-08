class CreateMovies < ActiveRecord::Migration[5.2]

    def change
        create_table :movies do |c|
            c.string :title
            c.text :description
            c.string :release_date
        end
    end
end