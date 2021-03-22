Rails.application.routes.draw do
  root 'calendars#show'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    patch "confirm_update", to: "users/registrations#confirm_update"
  end

  resources :calendars do
    resources :goals
    resources :notes, only: %i[new create show edit update]
  end

  post 'review_record/:id', to: 'review_records#create'
  delete 'review_record/:id', to: 'review_records#destroy'

  get '/calendar/:calendar_id/goals', to: 'goals#create_goal'
  get '/incremental_search_tags', to: 'notes#incremental_search_tags'
  get '/search_note', to: 'notes#search_note'
end
