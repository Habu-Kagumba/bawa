Rails.application.routes.draw do
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "signup" => "users#new"

  root "static#home"

  post "users/check_email" => "users#check_email", as: :check_email
  post "users/check_username" => "users#check_username", as: :check_username
  post "sessions/check_username_email" => "sessions#check_username_email",
    as: :check_username_email

  # users
  resources :users, path: "/profile"
end
