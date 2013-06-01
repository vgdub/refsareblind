Poolboys::Application.routes.draw do

# SESSIONS
  get "/login" => "sessions#new", as: :login
  post "/login" => "sessions#create", as: :post_login
  get "/logout" => "sessions#destroy", as: :logout

# REGISTRATIONS
  get "/signup" => "registrations#new", as: :signup
  post "/signup" => "registrations#create", as: :post_signup

# USERS
  get "/account" => "users#account", as: :user_account_url

end
