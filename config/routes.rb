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
  post "/pools/payment" => "pools#post_pool_payment", as: :post_pool_payment
  get "/pools/:slug/admin" => "pools#admin_dashboard", as: :pool_admin_dashboard

# ENTRIES
  get "/pools/:slug/join" => "pool_users#new", as: :new_pool_user
  post "/pool-users" => "pool_users#create", as: :post_pool_users
  post "/pool-users/approve-entry" => "pool_users#approve_entry", as: :approve_entry
  post "/pool-users/remove-approval" => "pool_users#remove_approval", as: :remove_approval

# PICKS
  get "/pools/:slug/picks/new" => "nfl_picks#new", as: :new_nfl_pick
  post "/pools/:slug/picks/update_unlocked_survival_pick" => "nfl_picks#update_unlocked_survival_pick", as: :update_unlocked_survival_pick

end
