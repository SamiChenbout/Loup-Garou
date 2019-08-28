Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :characters, only: [:index, :show]
  resources :games, only: [:show, :create, :destroy] do
    resources :players, except: [:edit, :new]
    resources :lover_couples, only: [:create, :destroy]
    resources :messages, only: :create
    resources :game_events, only: [:create, :destroy]

    post 'games/:game_id/random_loup_vote', to: 'game_events#random_loup_vote'
    get "/random_couple", to: "lover_couples#random_couple"
    get "/voyante_next_step", to: "games#voyante_next_step"
  end
    get "/find", to: "games#find_game"
end
