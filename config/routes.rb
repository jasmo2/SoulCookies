Rails.application.routes.draw do
  get 'sessions/new'
  resources :customers_users
  mount Shoppe::Engine => "/shoppe"
  root 'products#index'

  get 'products/:category_id/:product_id' => 'products#show', :as => 'product'
  get 'products/add_to_basket'
  post 'products/:category_id/:product_id/buy' => 'products#add_to_basket', :as => 'buy_product'

  # Facebook
  post 'auth/facebook/callback', to: 'sessions#create_fb'
  get 'auth/failure', to: redirect('/')

  # Sessions
  get 'sessions/create', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # Orders & checkout
  resources :address, except: [:index,:show]


  match "checkout", to: "orders#checkout", as: "checkout", via: [:get, :patch]
  match "checkout/express", to: "orders#express", via: [:get, :post]
  match "checkout/pay", to: "orders#payment", as: "checkout_payment", via: [:get, :post]
  match "checkout/confirm", to: "orders#confirmation", as: "checkout_confirmation", via: [:patch, :post]

  post 'basket/:order_item_id' => 'orders#change_item_quantity', :as => 'adjust_basket_item_quantity'
  delete 'basket/:order_item_id' => 'orders#change_item_quantity'
  delete 'basket/delete/:order_item_id' => 'orders#remove_item', :as => 'remove_basket_item'


  get 'compra_exitosa/:order_number' => 'orders#successful'




end
