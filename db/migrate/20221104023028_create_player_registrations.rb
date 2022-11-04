class CreatePlayerRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :player_registrations do |t|
      t.integer :player_id
      t.integer :team_id
      t.boolean :need_uniform
      t.string :uniform_jersey_size
      t.string :uniform_short_size
      t.decimal :amount, precision: 8, scale: 2
      t.string :charge_identifier

      t.timestamps
    end
  end
end

