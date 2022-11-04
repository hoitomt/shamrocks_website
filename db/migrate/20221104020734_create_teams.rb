class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.integer :graduation_year
      t.integer :school_year_start
      t.integer :grade_level
      t.string :gender
      t.string :coach_first_name
      t.string :coach_last_name
      t.string :coach_email

      t.timestamps
    end
  end
end
