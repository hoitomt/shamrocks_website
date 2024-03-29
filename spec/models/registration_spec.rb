require 'rails_helper'

RSpec.describe Registration, type: :model do
  let(:registration_params) {
    {
      player_first_name: 'Lebron',
      player_last_name: 'James',
      need_uniform: false,
      parent_first_name: 'Magic',
      parent_last_name: 'Johnson',
      email: 'magic_man@lakers.com',
      grade_level: 'fourth_grade',
      team_gender: 'Girls'
    }
  }

  it 'creates a new registration' do
    expect {
      Registration.create(registration_params)
    }.to change{Registration.count}.by(1)
  end

  describe 'registration_scenarios' do
    it 'grade missing' do
      registration_params[:grade_level] = nil
      registration = Registration.new(registration_params)
      expect(registration.calculate_grade_level_cost).to eq nil
      expect(registration.valid?).to eq false
    end

    it '8th grade, no uniform' do
      registration_params[:grade_level] = 'eighth_grade'
      registration = Registration.new(registration_params)
      expect(registration.calculate_grade_level_cost).to eq 0
      expect(registration.valid?).to eq true
    end

    it '8th grade, with jersey' do
      registration_params[:grade_level] = 'eighth_grade'
      registration_params[:need_uniform] = true
      registration_params[:uniform_jersey_size] = 'kids_large'
      registration = Registration.new(registration_params)
      expect(registration.calculate_grade_level_cost).to eq 25
      expect(registration.valid?).to eq true
    end

    it '7th grade, with jersey and shorts' do
      registration_params[:grade_level] = 'seventh_grade'
      registration_params[:need_uniform] = true
      registration_params[:uniform_jersey_size] = 'kids_large'
      registration_params[:uniform_short_size] = 'kids_large'
      registration = Registration.new(registration_params)
      expect(registration.calculate_grade_level_cost).to eq 200
      expect(registration.valid?).to eq true
    end

    it '5th grade girls, with no uniform' do
      registration_params[:grade_level] = 'fifth_grade'
      registration = Registration.new(registration_params)
      expect(registration.calculate_grade_level_cost).to eq 25
      expect(registration.valid?).to eq true
    end

    it '5th grade boys, with no uniform' do
      registration_params[:grade_level] = 'fifth_grade'
      registration_params[:team_gender] = 'Boys'
      registration = Registration.new(registration_params)
      expect(registration.calculate_grade_level_cost).to eq 100
      expect(registration.valid?).to eq true
    end

    it 'requires at least 1 uniform piece if need_uniform is true' do
      registration_params[:grade_level] = 'seventh_grade'
      registration_params[:need_uniform] = true
      registration = Registration.new(registration_params)
      expect(registration.valid?).to eq false
    end
  end

  describe 'grade_level_display' do
    it 'returns the display name' do
      registration = Registration.new(registration_params)
      expect(registration.grade_level_display).to eq '4th Grade'
    end
  end

  describe 'duplicate registrations' do
    it 'adds an error for duplicate registrations' do
      Registration.create(registration_params)
      dup_registration = Registration.new(registration_params)
      expect(dup_registration.valid?).to eq false
      expect(dup_registration.errors[:grade_level].first).to match "A registration already exists"
    end

    it 'does not add an error for dupliate registrations if the override flag is set' do
      Registration.create(registration_params)
      dup_registration = Registration.new(registration_params)
      dup_registration.override_duplicate_registration = true
      expect(dup_registration.valid?).to eq true
    end
  end

  describe 'registration selector' do

  end

  describe 'update registration' do
    let(:registration) { Registration.create(registration_params) }

    it 'updates the uniform '
    it 'does not allow uniform subtractions show message that they need to contact Shamrocks'

  end
end
