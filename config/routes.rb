Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [ :create ]

      post "login",       to: "auth#login"
      delete "logout",    to: "auth#logout"

      resources :books do
        collection do
          get "search"
        end
      end

      resources :borrowings, only: [ :index, :show, :create, :update ]

      get "dashboard", to: "dashboard#index"
    end
  end
end
