class UserRegistrationMailer < ApplicationMailer
  def confirmation_instructions
    @user_registration = params[:user_registration]

    mail(to: @user_registration.email, subject: "Confirmation instructions")
  end
end
