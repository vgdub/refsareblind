RefsAreBlind::Application.routes.draw do
  root :to => "pages#homepage"

# SESSIONS
  get "/login" => "sessions#new", as: :login
  post "/login" => "sessions#create", as: :post_login
  get "/logout" => "sessions#destroy", as: :logout

# REGISTRATIONS
  get "/signup" => "registrations#new", as: :signup
  post "/signup" => "registrations#create", as: :post_signup

# USERS
  get "/account" => "users#account", as: :user_account

# POOLS
  get "/pools/new" => "pools#new", as: :new_pool
  post "/pools" => "pools#create", as: :post_pools
  get "/pools/:slug" => "pools#show", as: :pool
  get "/pools" => "pools#index", as: :pools
  get "/pools/:slug/payment" => "pools#pool_payment", as: :pool_payment

end
