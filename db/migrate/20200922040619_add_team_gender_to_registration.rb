class AddTeamGenderToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :team_gender, :string
  end
end
