Rails.application.routes.draw do
  resources :discount_codes
  resources :colors
  resources :orders
  resources :orderd_products
  resources :msgs
  resources :tags
  resources :brands
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
