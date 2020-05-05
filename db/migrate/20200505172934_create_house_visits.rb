class CreateHouseVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :house_visits do |t|
      t.integer :house_id
      t.integer :buyer_id
    end
  end
end
