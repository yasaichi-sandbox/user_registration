module Web
  module Views
    module UserRegistrations
      class Create
        include Web::View

        template 'user_registrations/new'
      end
    end
  end
end
