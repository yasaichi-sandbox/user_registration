require 'features_helper'

RSpec.feature 'Register a new user' do
  before do
    visit Web.routes.new_user_registration_url
  end

  it 'should not register with an invalid email address' do
    fill_in 'Email', with: 'invalid'
    click_on 'Sign up'

    expect(page).to have_content('Email is invalid')
  end

  it 'should register with a valid email address' do
    valid_email_address = 'test@example.com'

    fill_in 'Email', with: valid_email_address
    click_on 'Sign up'

    expect(page).to have_content('A message with a confirmation link has been sent')

    open_email(valid_email_address)
    current_email.click_link 'Confirm my account'

    expect(page).to have_content('Please fill out the form below')
  end

  after do
    Hanami::Mailer.deliveries.clear
    UserRegistrationRepository.new.clear
  end
end
