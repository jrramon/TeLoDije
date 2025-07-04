Rails.application.routes.draw do
  root 'predictions#index'
  
  # Authentication routes
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # Rankings and profiles
  get '/rankings', to: 'rankings#index'
  get '/profile/:id', to: 'profiles#show', as: :profile
  
  # Predictions, votes, and comments
  resources :predictions do
    resources :votes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  # Follows
  resources :users, only: [] do
    resource :follow, only: [:create, :destroy]
  end
  
  # Notifications
  resources :notifications, only: [:index, :show] do
    member do
      patch :mark_as_read
    end
    collection do
      patch :mark_all_as_read
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
