Rails.application.routes.draw do
  resources :chats
  post "chats/:id/edit" => "chats#edit"

  get "up" => "rails/health#show", as: :rails_health_check
  root "chats#index"
end
