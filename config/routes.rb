Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Root page
  root 'welcome#index'
  # Route to get user self portfolio
  get '/users/self/portfolio', to: "users#selfPortfolio"
  # Stock routes
  get '/stock/search', to: "stocks#search"
  # User Stocks
  post '/users/stocks', to: "stocks#create"
  delete '/users/stocks', to: "stocks#remove"
  get '/users/friends', to: "users#readFriends"
  delete '/users/friends', to: "users#removeFriend"
  get '/users/:id', to: "users#readById", as: "users_shows"
  get '/friends/search', to: "users#search"
  post '/friends/add', to: "users#addFriend"
end
