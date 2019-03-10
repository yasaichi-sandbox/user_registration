class UserRegistrationsController < ApplicationController
  def new
    @user_registration = UserRegistration.new
  end

  def create
    @user_registration = UserRegistration.new(user_registration_params)

    if @user_registration.save
      redirect_to complete_user_registrations_url
    else
      render :new
    end
  end

  def complete; end

  private

  def user_registration_params
    params.require(:user_registration).permit(:email)
  end
end
