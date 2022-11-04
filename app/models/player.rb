class Player < ApplicationRecord
  validates :first_name, :last_name,
            :parent_first_name, :parent_last_name,
            :email, :grade_level, :team_gender,
            presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def parent_name
    "#{parent_first_name} #{parent_last_name}"
  end
end
