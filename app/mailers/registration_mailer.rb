class RegistrationMailer < ApplicationMailer
  def confirmation(registration)
    @registration = registration
    mail(to: @registration.email, subject: "Thank you for registering #{@registration.player_name}")
  end
end
