require 'application_system_test_case'

class UserRegistrationsTest < ApplicationSystemTestCase
  test 'can register with a valid email address' do
    valid_email_address = 'test@example.com'
    visit new_user_registration_path

    fill_in 'Email', with: valid_email_address
    click_on 'Sign up'

    assert_text 'A message with a confirmation link has been sent'

    open_email(valid_email_address)
    current_email.click_link 'Confirm my account'

    assert_text 'Please fill out the form below'
  end

  test "can't register with an invalid email address" do
    visit new_user_registration_path

    fill_in 'Email', with: 'invalid'
    click_on 'Sign up'

    assert_text 'Email is invalid'
  end
end
