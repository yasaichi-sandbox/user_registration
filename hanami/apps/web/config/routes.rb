resources :user_registrations, only: %i[new create] do
  collection do
    get 'complete'
  end

  resource :confirmation, only: %i[new], module: :user_registrations
end
