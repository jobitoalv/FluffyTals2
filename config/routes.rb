Rails.application.routes.draw do
  get 'item/page'
  devise_for :users 
  root 'home#page'
  resources :products
  get "payments/success", to: "payments#success"
  post "payments/webhook", to: "payments#webhook"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
