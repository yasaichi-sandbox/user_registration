module Mailers
  class UserRegistrationConfirmation
    include Hanami::Mailer
    include Hanami::Helpers::LinkToHelper

    from    'from@example.com'
    to      :recipient
    subject 'Confirmation instructions'

    private

    def recipient
      user_registration.email
    end
  end
end
