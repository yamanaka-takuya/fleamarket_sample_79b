Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get  'users/sign_up', to: 'users/registrations#new'
    get '/users/sign_out', to: 'devise/sessions#destroy'
    get  'users/addresses', to: 'users/registrations#new_address'
    post 'users/addresses', to: 'users/registrations#create_address'
  end
  resources :listings , only: [:index]
  resources :mypages, only: [:index]
  resources :items, only: [:index, :show, :new, :create] do
    member do
      get 'buy'
    end
  end
  resources :users, only: [:edit, :update, :create]
  resources :card, only: [:create, :show, :edit, :new, :destroy] do
    collection do
      post 'delete', to: 'card#delete'
      # post 'show'
      # post 'new', to: 'card#new'
      # get 'registration'
      get 'registration', to:'card#registration'
    end
    # member do
    get 'show', to: 'card#show'
    get 'confirmation', to: 'card#confirmation'
    # end
  end 
  resources :addresses, only: [:create, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # after
  root 'front#index'
end
