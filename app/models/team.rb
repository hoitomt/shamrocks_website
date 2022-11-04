class Team < ApplicationRecord
  validates :graduation_year, :school_year_start,
            :grade_level, :gender,
            :coach_first_name, :coach_last_name, :coach_email,
            presence: true
end
