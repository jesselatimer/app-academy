Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] # eventually except: [:index]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: :new
  end
  resources :albums, except: :new  do
    resources :tracks, only: :new
  end
  resources :tracks, except: :new

  root "bands#index"
end
