require 'hanami/interactor'

class StartUserRegistration
  include Hanami::Interactor

  class Validator
    include Hanami::Validations

    validations do
      required(:email).filled(:str?, format?: URI::MailTo::EMAIL_REGEXP)
    end
  end

  def initialize(mailer:, repository:, token_generator:)
    @mailer = mailer
    @repository = repository
    @token_generator = token_generator
  end

  def call(params)
    @repository.transaction do
      user_registration = @repository.create(
        email: params[:email],
        confirmation_token: @token_generator.call
      )

      @mailer.deliver(user_registration: user_registration)
    end
  end

  private

  def valid?(params)
    Validator.new(params).validate.yield_self do |result|
      result.messages.each_key do |key|
        error("#{key.capitalize} is invalid")
      end

      result.success?
    end
  end
end
