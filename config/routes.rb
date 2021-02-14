Rails.application.routes.draw do
  root 'calendars#show'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :calendars do
    resources :goals
  end
  resources :notes, only:[:new, :create, :show, :edit, :update]
end
