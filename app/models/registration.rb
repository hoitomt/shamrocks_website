class Registration < ApplicationRecord
  SIZES = [
    "Not Needed",
    "Kids Small",
    "Kids Medium",
    "Kids Large",
    "Kids X-Large",
    "Adult Small",
    "Adult Medium",
    "Adult Large",
    "Adult X-Large",
  ]

  validates :player_first_name, :player_last_name,
            :parent_first_name, :parent_last_name,
            :email, :grade_level,
            presence: true
end
