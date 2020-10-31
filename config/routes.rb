Rails.application.routes.draw do
  get 'order_items/create'
  get 'order_items/update'
  get 'order_items/destroy'
  get 'cart/show'
  resources :songs
 get 'profile/index'
  get 'profile/show'
  get 'profile/edit'
  get 'profile/update'
  get 'profile/delete'
devise_for :profiles, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: "registrations" }
  resources :ads
   
   resources :order_items
   get 'cart', to: 'cart#show'

  root 'ads#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
