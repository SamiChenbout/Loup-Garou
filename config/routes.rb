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

    get "/random_couple", to: "game_events#random_couple"
    get "/voyante_next_step", to: "game_events#voyante_next_step"
    get "/random_loup_vote", to: "game_events#random_loup_vote"
    get "/random_sorciere_vote", to: "game_events#random_sorciere_vote"

    get "/couple", to: "game_events#couple"
  end
  get "/find", to: "games#find_game"
end
