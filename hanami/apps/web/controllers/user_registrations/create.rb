module Web
  module Controllers
    module UserRegistrations
      class Create
        include Web::Action

        expose :error_messages

        def initialize(interactor: StartUserRegistration.new(
          mailer: Mailers::UserRegistrationConfirmation,
          repository: UserRegistrationRepository.new,
          token_generator: Utils::UrlSafeTokenGenerator
        ))
          @interactor = interactor
        end

        def call(params)
          result = @interactor.call(params[:user_registration])

          if result.successful?
            redirect_to routes.complete_user_registrations_url
          else
            @error_messages = result.errors
            self.status = 422
          end
        end
      end
    end
  end
end
