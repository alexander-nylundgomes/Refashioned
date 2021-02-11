Rails.application.routes.draw do
  resources :product_images
  resources :qualities
  resources :sell_requests
  resources :miscs
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
  get 'search/:tag', :to=> 'products#search'
  post 'create_payment', :to=> 'orders#create_payment'
  get 'shipping_data', :to=> 'miscs#shipping_data'
  get 'cr', :to=> 'orders#create_reciept'
  get 'all_products', :to=> 'products#all'

  get 'product_tags/:id', :to=> 'tags#product_tags'
  patch 'product_tags/:id', :to=> 'tags#update_product_tags'


  get 'admin/orders/get_products/:id', :to=> 'orders#get_products'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
