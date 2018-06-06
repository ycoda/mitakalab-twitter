Rails.application.routes.draw do
  devise_for :users
  resources :tweets, only: [:index, :new, :create]

  get 'users/index' => 'users#index'
  get 'users/show/:id' => 'users#show'
  root to: 'tops#index'
end
