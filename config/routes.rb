Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :tweets, only: [:index, :new, :create]

  get 'users/index' => 'users#index'
  get 'users/show/:id' => 'users#show'
  root to: 'tops#index'
end
