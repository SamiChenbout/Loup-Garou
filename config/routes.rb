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

    get "/role", to: "games#role"

    get "/cupidon", to: "lover_couples#cupidon"
    get "/random_couple_choose", to: "lover_couples#random_couple_choose"
    get "/voyante", to: "game_events#voyante"
    get "/voyante_next_step", to: "game_events#voyante_next_step"
    get "/loup", to: "game_events#loup"
    get "/random_loup_choose", to: "game_events#random_loup_choose"
    get "/sorciere", to: "game_events#sorciere"
    get "/random_sorciere_choose", to: "game_events#random_sorciere_choose"
    get "/chasseur", to: "game_events#chasseur"
    get "/random_chasseur_kill", to: "game_events#random_chasseur_kill"

    get "/when_day_comes", to: "game_events#when_day_comes"
    get "/when_night_comes", to: "game_events#when_night_comes"
    get "/when_night_talk", to: "game_events#when_night_talk"
    get "/end_game", to: "games#end_game"
    get "/couple", to: "games#couple"
    get "/reveal", to: "games#reveal"

    get "/night", to: "games#night"
    get "/day", to: "games#day"
  end

  get "/find", to: "players#find_game"
  get "/animation", to: "pages#animation"
end
