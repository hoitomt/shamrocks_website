class WaiverMailer < ApplicationMailer
  def reminder_email(registration)
    @registration = registration
    mail(to: registration.email, subject: "Shamrocks: Waiver signature requested")
  end
end
