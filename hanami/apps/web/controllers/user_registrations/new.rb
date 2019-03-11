module Web
  module Controllers
    module UserRegistrations
      class New
        include Web::Action

        expose :error_messages

        def call(params)
          @error_messages = []
        end
      end
    end
  end
end
