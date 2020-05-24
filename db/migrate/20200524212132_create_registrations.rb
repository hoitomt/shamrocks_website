class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.string :player_first_name
      t.string :player_last_name
      t.string :parent_first_name
      t.string :parent_last_name
      t.string :email
      t.integer :grade_level
      t.integer :graduation_year
      t.boolean :need_uniform
      t.string :uniform_jersey_size
      t.string :uniform_short_size

      t.timestamps
    end
  end
end
