Rails.application.routes.draw do
  resources :games do
    resources :pieces
    patch 'castle_kingside', to: 'games#castle_kingside', as: :castle_kingside
    patch 'castle_queenside', to: 'games#castle_queenside', as: :castle_queenside
  end
  root 'games#index'
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
