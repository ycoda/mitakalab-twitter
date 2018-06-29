Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:       "users/sessions",
    registrations:  "users/registrations",
    passwords:      "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :tweets, only: [:index, :new, :create, :destroy]
  root to: 'tops#index'
end
