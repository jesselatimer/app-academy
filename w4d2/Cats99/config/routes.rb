Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:new, :create] do
    post "/deny", to: "cat_rental_requests#deny"
    post "/approve", to: "cat_rental_requests#approve"
  end
end
