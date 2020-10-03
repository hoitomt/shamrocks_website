class Registration < ApplicationRecord
  SIZES = [
    "Kids Small",
    "Kids Medium",
    "Kids Large",
    "Kids X-Large",
    "Adult Small",
    "Adult Medium",
    "Adult Large",
    "Adult X-Large",
  ]

  GRADE_LEVELS = {
    fourth_grade: {
      display_name: "4th Grade",
      amount: 50
    },
    fifth_grade: {
      display_name: "5th Grade",
      amount: 100
    },
    sixth_grade: {
      display_name: "6th Grade",
      amount: 100
    },
    seventh_grade: {
      display_name: "7th Grade",
      amount: 150
    },
    eighth_grade: {
      display_name: "8th Grade",
      amount: 0
    },
  }

  TEAM_GENDERS = ['Boys', 'Girls']

  validates :player_first_name, :player_last_name,
            :parent_first_name, :parent_last_name,
            :email, :grade_level, :team_gender,
            presence: true
  validates :grade_level, :inclusion=> { :in => %w{fourth_grade fifth_grade sixth_grade seventh_grade eighth_grade} }
  validate :uniform_piece_is_required_if_need_uniform_is_true

  def uniform_piece_is_required_if_need_uniform_is_true
    if need_uniform
      if uniform_jersey_size.blank? && uniform_short_size.blank?
        errors.add(:need_uniform, "- must select either a jersey size or a shorts size if true")
      end
    end
  end

  def self.grade_level_name_map
    GRADE_LEVELS.map do |key, grade_level|
      [grade_level[:display_name], key.to_s]
    end
  end

  def calculate_grade_level_cost
    return nil unless grade_level
    grade_level_map = GRADE_LEVELS[grade_level.to_sym]
    return nil unless grade_level_map

    cost = grade_level_map[:amount] || 0
    if need_uniform
      cost += 25 if uniform_jersey_size.present? && uniform_jersey_size != 'Not Needed'
      cost += 25 if uniform_short_size.present? && uniform_short_size != 'Not Needed'
    end
    return cost
  end

  def player_name
    "#{player_first_name} #{player_last_name}"
  end

  def player_name_with_year
    year = self.created_at.year
    "#{player_name} | Grade: #{grade_level} | Year: #{year}"
  end

  def parent_name
    "#{parent_first_name} #{parent_last_name}"
  end

  def grade_level_selected
    grade_level.blank? || grade_level == "0" ? nil : grade_level
  end

  def team_gender_selected
    team_gender.blank? ? nil : team_gender
  end

  def uniform_jersey_size_selected
    uniform_jersey_size == "Not Needed" ? nil : uniform_jersey_size
  end

  def uniform_short_size_selected
    uniform_jersey_size == "Not Needed" ? nil : uniform_short_size
  end

  def need_uniform_h
    need_uniform ? "Yes" : "No"
  end

  def grade_level_display
    grade_level_map = GRADE_LEVELS[self.grade_level.to_sym] || {}
    return grade_level_map[:display_name]
  end
end
