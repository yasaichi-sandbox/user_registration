class UserRegistrationRepository < Hanami::Repository
  def find_by_confirmation_token(token)
    user_registrations.where(confirmation_token: token).limit(1).one
  end
end
