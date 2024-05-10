Rails.application.routes.draw do
  root "livros#index"

  resources :livros

  devise_for :usuarios do
    collection do
      get :livros
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :usuarios, only: [] do
    collection do
      get :livros
    end
  end

  namespace :api do
    namespace :v1 do
      resources :usuario_livros, only: [:index, :show]
    end
  end
end
