Rails.application.routes.draw do
  resources :colors, only: [ :index ]

  # Defines the root path route ("/")
  root "colors#index"
end
