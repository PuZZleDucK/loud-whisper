Rails.application.routes.draw do
  resources :chats

  get "up" => "rails/health#show", as: :rails_health_check
  root "chats#index"
end
