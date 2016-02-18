Rails.application.routes.draw do


  resources :customers_users
  mount Shoppe::Engine => "/shoppe"
  root 'products#index'

  get 'products/:category_id/:product_id' => 'products#show', :as => 'product'
  get 'products/add_to_basket'
  post 'products/:category_id/:product_id/buy' => 'products#add_to_basket', :as => 'buy_product'

  # Facebook
  post 'auth/facebook/callback'=> 'sessions#create_fb'
  get 'auth/failure'=> redirect('/')

  # Sessions
  get 'sessions/new' => 'sessions#new'
  match 'sessions/create'=> 'sessions#create', via: [:get,:post]
  get 'signout'=> 'sessions#destroy', as: 'signout'
  # reset password
  resources :password_resets

  # Orders & checkout
  resources :address, except: [:index,:show]


  match "checkout"=> "orders#checkout", as: "checkout", via: [:get, :patch]
  match "checkout/express"=> "orders#express", via: [:get, :post]
  match "checkout/pay"=> "orders#payment", as: "checkout_payment", via: [:get, :post]
  match "checkout/confirm"=> "orders#confirmation", as: "checkout_confirmation", via: [:patch, :post]

  post 'basket/:order_item_id' => 'orders#change_item_quantity', as: 'adjust_basket_item_quantity'
  delete 'basket/:order_item_id' => 'orders#change_item_quantity'
  delete 'basket/delete/:order_item_id' => 'orders#remove_item', as: 'remove_basket_item'

  get 'compra_exitosa/:order_number' => 'orders#successful'

  # Cookie Tracker
  get "cookie_tracker" => "cookie_tracker#index"
  post "cookie_tracker" => "cookie_tracker#search"
  get 'cookie_tracker/steps' => 'cookie_tracker#steps'




end
