require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create action" do
    it "should let user create a new game in the database" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { 
        game: {
          name: 'Hello!',
        } 
      }
      expect(response).to redirect_to root_path
      game = Game.last
      expect(game.name).to eq("Hello!")
      #expect(game.white_player_id).to eq(user)
    end
  end

  describe "games#new action" do
    it "Should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end
end