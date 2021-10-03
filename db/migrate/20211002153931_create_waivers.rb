class CreateWaivers < ActiveRecord::Migration[6.1]
  def change
    create_table :waivers do |t|
      t.integer :registration_id
      t.boolean :confirmation

      t.timestamps
    end
  end
end
