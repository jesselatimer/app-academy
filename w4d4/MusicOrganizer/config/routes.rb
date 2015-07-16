Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] # eventually except: [:index]
  resource :session, only: [:new, :create, :destroy]
end
