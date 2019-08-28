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

    get "/sorciere", to: "game_events#sorciere" do
      get "/random_sorciere_vote", to: "game_events#random_sorciere_vote"
    end

    get "/couple", to: "game_events#couple" do
      get "/random_couple", to: "game_events#random_couple"
    end

    get "/voyante", to: "game_events#voyante" do
      get "/voyante_next_step", to: "game_events#voyante_next_step"
    end

    get "/chasseur", to: "game_events#chasseur" do
      get "/chasseur_random_kill", to: "game_events#chasseur_random_kill"
    end


    get "/random_loup_vote", to: "game_events#random_loup_vote"
  end

  get "/find", to: "games#find_game"
end
