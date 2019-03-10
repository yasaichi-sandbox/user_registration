require 'test_helper'

class UserRegistrationTest < ActiveSupport::TestCase
  setup do
    @user_registration = UserRegistration.new(email: "test@example.com")
  end

  test "should generate a confirmation token automatically" do
    @user_registration.save!

    assert @user_registration.confirmation_token.present?
  end

  test "should send an instruction email for new records" do
    @user_registration.save!
    instruction_email = ActionMailer::Base.deliveries.last

    assert_equal @user_registration.email, instruction_email.to.first
    assert_equal "Confirmation instructions", instruction_email.subject
  end
end
