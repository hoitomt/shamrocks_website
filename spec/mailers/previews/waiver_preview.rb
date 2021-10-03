# Preview all emails at http://localhost:3000/rails/mailers/waiver
class WaiverPreview < ActionMailer::Preview
  def reminder_email
    registration_params = {
      player_first_name: 'Lebron',
      player_last_name: 'James',
      need_uniform: false,
      parent_first_name: 'Magic',
      parent_last_name: 'Johnson',
      email: 'magic_man@lakers.com',
      grade_level: 'fourth_grade',
      team_gender: 'Girls'
    }
    registration = Registration.create(registration_params)
    WaiverMailer.reminder_email(registration)
  end
end
