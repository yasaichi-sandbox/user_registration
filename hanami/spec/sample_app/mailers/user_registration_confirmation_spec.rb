RSpec.describe Mailers::UserRegistrationConfirmation, type: :mailer do
  subject { Hanami::Mailer.deliveries.last }

  let(:email) { 'test@example.com' }
  let(:user_registration) { double('user_registration', email: email, confirmation_token: 'asdfghjkl') }

  before do
    described_class.deliver(user_registration: user_registration)
  end

  its('to.first') { is_expected.to eq user_registration.email }
  its(:subject) { is_expected.to eq 'Confirmation instructions' }

  after do
    Hanami::Mailer.deliveries.clear
  end
end
