Rails.application.routes.draw do
  resources :artists
  get 'order_items/create'
  get 'order_items/update'
  get 'order_items/destroy'
  get 'cart/show'
  resources :songs do
    collection do
      get :track_no_of_play
      get :track_no_of_download
    end
  end
 # get 'profile/index'
 #  get 'profile/show'
 #  get 'profile/edit'
 #  get 'profile/update'
 #  get 'profile/delete'
devise_for :profiles, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: "registrations" }
  resources :ads do
    collection do
      get :track_view_from_playlist
    end
  end
   
   resources :order_items
   get 'cart', to: 'cart#show'

  root 'ads#index'
  resources :profiles do
    resources :playlists do
      collection do
        get :add_song
        get :get_song_info
        get :remove_song
      end
    end
  end

  resources :playlists do
    member do
      get :show_public_playlist
      get :like_public_playlist
    end

    collection do
      get :public_playlists
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
