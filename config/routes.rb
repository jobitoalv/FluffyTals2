Rails.application.routes.draw do
  get 'item/page'
  post "payments/page" , to: "payments#page" , as: 'payment_page'
  devise_for :users 
  root 'home#page'
  resources :products
  get "payments/success", to: "payments#success"
  #post "payments/webhook", to: "payments#webhook"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
