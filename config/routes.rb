Rails.application.routes.draw do
  resources :games, :only => [:new, :create, :index]
  root "games#new"

  get "/winner/:winner/:loser" => "games#winner", as: :winner
  get "/start_game" => "games#start_game"
  post "/settings" => "games#settings", as: :settings
  get "/game_over/:id" => "games#game_over", as: :game_over
  post "/latecomer" => "games#latecomer", as: :latecomer
  post "/clear" => "games#clear", as: :clear
  delete "/player/:id/delete" => "games#destroy", as: :delete
end
