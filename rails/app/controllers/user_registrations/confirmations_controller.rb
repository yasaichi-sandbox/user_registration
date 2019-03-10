class UserRegistrations::ConfirmationsController < ApplicationController
  def new
    # NOTE: Only check the existence of a confirmation token for now
    UserRegistration.find_by!(
      confirmation_token: params[:user_registration_confirmation_token]
    )
  end
end
