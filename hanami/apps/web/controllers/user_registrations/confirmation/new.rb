module Web
  module Controllers
    module UserRegistrations
      module Confirmation
        class New
          include Web::Action

          def initialize(repository: UserRegistrationRepository.new)
            @repository = repository
          end

          # NOTE: Only check the existence of a confirmation token for now
          def call(params)
            user_registration =
              @repository.find_by_confirmation_token(params[:user_registration_id])

            halt 404 unless user_registration
          end
        end
      end
    end
  end
end
