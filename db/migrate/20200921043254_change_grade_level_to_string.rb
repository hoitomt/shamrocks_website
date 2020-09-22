class ChangeGradeLevelToString < ActiveRecord::Migration[6.0]
  def change
    change_column :registrations, :grade_level, :string
  end
end
