Rails.application.routes.draw do
  root "static#home"

  post "users/check_email" => "users#check_email", as: :check_email
  post "users/check_username" => "users#check_username", as: :check_username

  # users
  resources :users, path: "/profile"
end
