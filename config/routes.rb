Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resources :games do
    resources :pieces
    put '/make_move' => 'games#make_move'
    
    patch 'castle_kingside', to: 'games#castle_kingside', as: :castle_kingside
    patch 'castle_queenside', to: 'games#castle_queenside', as: :castle_queenside
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
