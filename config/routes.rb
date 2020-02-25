Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  resource "tweets"
  get "/see_tweets" => "tweets#my_tweets",:as=>:my_tweets
  get "/all_users" => "users#index",:as=>:all_users
  post "/follow/:user_id"=>"users#follow",:as=>:follow
  get "/followers/:user_id"=>"users#followers",:as=>:followers
  get "/followings/:user_id"=>"users#followings",:as=>:followings
  get "/profile/:user_id"=>"users#profile",:as=>:profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
