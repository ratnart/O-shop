Rails.application.routes.draw do
  resources :inventories
  resources :markets
  resources :items
  resources :users
  get '/login',to: 'home#login'
  
  get '/main',to:  'home#main'
  get '/profile',to: 'home#profile'
  get '/change_password',to: 'home#change_password'
  get '/home/logout'
  get '/my_market',to: 'home#my_market'
  get '/purchase_history',to: 'home#purchase_history'
  get '/my_inventory',to: 'home#my_inventory'
  get '/addItem',to: 'home#addItem'
  get '/sale_history',to:'home#sale_history'
  get '/top_seller',to:'home#top_seller'
  get '/home/register'
  get '/verify_buy' ,to: 'home#verify_buy'
  get '/addStock',to:'home#addStock'
  get '/reduceStock',to:'home#reduceStock'
  post '/home/verify_change_password'
  get '/buy_item' ,to:'home#buy_item'
 post '/home/check_user'
 post '/my_market',to: 'home#my_market'
 post '/verify_buy' ,to: 'home#verify_buy'
 post '/home/verify_add_stock'
 post '/home/verify_reduce_stock'
 post '/home/deleteItem'
 post '/addStock',to:'home#addStock'
 post '/reduceStock',to:'home#reduceStock'
 post '/addItem',to: 'home#addItem'
 post '/home/verify_addItem'
 post '/top_seller',to:'home#top_seller'
 post '/home/verify_top_seller'
 post '/home/register'
 post '/buy_item' ,to:'home#buy_item'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
