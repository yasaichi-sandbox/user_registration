Rails.application.routes.draw do
  resources :user_registrations, param: :confirmation_token, only: %i[new create] do
    collection do
      get 'complete'
    end

    resource :confirmation, only: %i[new], module: :user_registrations
  end
end
