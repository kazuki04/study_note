Rails.application.routes.draw do
  root 'goal_managements#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :notes, only:[:new, :create, :show, :edit, :update]
end
