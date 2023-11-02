Rottenpotatoes::Application.routes.draw do
  resources :users, only: [:create]
  resources :sessions, only: [:new, :create]
  resources :entitlements, only: [:create]
  resources :movies
  resources :professors
  get '/profile', to: 'users#profile', as: 'user_profile'
  delete '/sessions/clear', to: 'sessions#clear', as: 'clear_session'
  root :to => redirect('/sessions/new')

  resources :teaching_assistants do
    get 'new_office_hour', on: :collection
    post 'create_office_hour', on: :collection
  end

  resources :calendars
end
