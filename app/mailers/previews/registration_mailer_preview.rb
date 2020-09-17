# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class Previews::RegistrationMailerPreview < ActionMailer::Preview
  def confirmation_preview
    RegistrationMailer.confirmation(Registration.last)
  end
end
