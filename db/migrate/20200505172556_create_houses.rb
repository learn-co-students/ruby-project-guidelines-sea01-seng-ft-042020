class CreateHouses < ActiveRecord::Migration[5.0]
  def change
    create_table :houses do |t|
      t.float :price
      t.integer :agent_id
    end
  end
end
