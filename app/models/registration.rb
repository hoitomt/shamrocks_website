class Registration < ApplicationRecord
  has_many :waivers
  attr_accessor :override_duplicate_registration

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
    },
    fifth_grade: {
      display_name: "5th Grade",
    },
    sixth_grade: {
      display_name: "6th Grade",
    },
    seventh_grade: {
      display_name: "7th Grade",
    },
    eighth_grade: {
      display_name: "8th Grade",
    },
  }

  GRADE_LEVEL_GENDER_COSTS = {
    fourth_grade_boys: {
      amount: 50
    },
    fourth_grade_girls: {
      amount: 50
    },
    fifth_grade_boys: {
      amount: 100
    },
    fifth_grade_girls: {
      amount: 50
    },
    sixth_grade_boys: {
      amount: 100
    },
    sixth_grade_girls: {
      amount: 100
    },
    seventh_grade_boys: {
      amount: 150
    },
    seventh_grade_girls: {
      amount: 150
    },
    eighth_grade_boys: {
      amount: 0
    },
    eighth_grade_girls: {
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
  validate :registration_already_exists_for_this_time_period, on: :create

  def uniform_piece_is_required_if_need_uniform_is_true
    if need_uniform
      if uniform_jersey_size.blank? && uniform_short_size.blank?
        errors.add(:need_uniform, "- must select either a jersey size or a shorts size if true")
      end
    end
  end

  def registration_already_exists_for_this_time_period
    if override_duplicate_registration.nil?
      if Registration.exists?(player_first_name: player_first_name, player_last_name: player_last_name, grade_level: grade_level)
        errors.add(:grade_level, ": A registration already exists for #{player_name} in #{grade_level_display}. If you would like to enter a duplicate registration, please click the checkbox below")
      end
    end
  end

  def self.grade_level_name_map
    GRADE_LEVELS.map do |key, grade_level|
      [grade_level[:display_name], key.to_s]
    end.uniq
  end

  def calculate_grade_level_cost
    return nil unless self.grade_level and self.team_gender
    grade_level_gender_key = "#{self.grade_level}_#{self.team_gender.downcase}"
    grade_level_map = GRADE_LEVEL_GENDER_COSTS[grade_level_gender_key.to_sym]
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

  def self.with_unsigned_waiver(start_date)
    self.joins('left join waivers on registrations.id = waivers.registration_id').where('waivers.registration_id is null and registrations.created_at > ? and registrations.created_at < ?', start_date, DateTime.now)
  end
end
