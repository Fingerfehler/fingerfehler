Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resources :games do
    resources :pieces
    put '/make_move' => 'games#make_move'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
