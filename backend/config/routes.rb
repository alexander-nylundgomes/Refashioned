Rails.application.routes.draw do
  resources :categories
  resources :discount_codes
  resources :colors
  resources :orders
  resources :orderd_products
  resources :msgs
  resources :tags
  resources :brands
  resources :products

  get 'validate_stock', :to => 'products#validateStock'
  post 'validate_discount', :to=> 'discount_codes#tryCode'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
