Rottenpotatoes::Application.routes.draw do
  resources :users, only: [:create]
  resources :sessions, only: [:new, :create]
  resources :entitlements, only: [:create]
  resources :movies
  get '/profile', to: 'users#profile', as: 'user_profile'
  delete '/sessions/clear', to: 'sessions#clear', as: 'clear_session'
  root :to => redirect('/profile')
end
