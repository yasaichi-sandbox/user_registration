class UserRegistration < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_create :set_confirmation_token
  after_create :send_confirmation_instructions

  private

  def set_confirmation_token
    self.confirmation_token = SecureRandom.uuid
  end

  def send_confirmation_instructions
    UserRegistrationMailer.with(user_registration: self).confirmation_instructions.deliver_now
  end
end
