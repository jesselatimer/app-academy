Rails.application.routes.draw do

  resources :users, except: [:new, :edit] do
    resources :contacts, only: [:index]
    resources :comments, except: [:new, :edit, :show]
  end
  resources :contacts, except: [:new, :edit, :index] do
    resources :comments, except: [:new, :edit, :show]
  end
  resources :contact_shares, only: [:create, :destroy]

  #HTTP method / URL / CONTROLLER / alias
  # get '/users', to: 'users#index', as: 'users'
  # post '/users', to: 'users#create'
  # get '/users/new', to: 'users#new', as: 'new_user'
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get '/users/:id', to: 'users#show', as: 'user'
  # patch '/users/:id', to: 'users#update'
  # put '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'

end
