# Preview all emails at http://localhost:3000/rails/mailers/user_registration_mailer
class UserRegistrationMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user_registration = UserRegistration.new(
      confirmation_token: "asdfghjkl",
      email: "test@example.com"
    )

    UserRegistrationMailer.with(user_registration: user_registration).confirmation_instructions
  end
end
