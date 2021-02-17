Rails.application.routes.draw do
  root 'calendars#show'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :calendars do
    resources :goals
  end
  get '/calendar/:calendar_id/goals', to: 'goals#create_goal'
  resources :notes, only:[:new, :create, :show, :edit, :update]
end
