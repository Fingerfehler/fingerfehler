require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe "is_valid_move knight" do 
    it "should be an invalid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      piece = Knight.create(:x_coord => 3, :y_coord => 3, :game_id => game.id)
      expect(piece.valid_move?(3,4)).to eq false
      expect(piece.valid_move?(4,4)).to eq false
      expect(piece.valid_move?(1,3)).to eq false
      expect(piece.valid_move?(2,0)).to eq false
      expect(piece.valid_move?(3,1)).to eq false
      expect(piece.valid_move?(5,1)).to eq false
      expect(piece.valid_move?(3,-1)).to eq false
      expect(piece.valid_move?(99,-10)).to eq false
    end
  end
  describe "is_valid_move knight" do 
    it "should be valid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      piece = Knight.create(:x_coord => 3, :y_coord => 3, :game_id => game.id)
      expect(piece.valid_move?(2,5)).to eq true
      expect(piece.valid_move?(4,5)).to eq true
      expect(piece.valid_move?(5,4)).to eq true
      expect(piece.valid_move?(5,2)).to eq true
      expect(piece.valid_move?(4,1)).to eq true
      expect(piece.valid_move?(2,1)).to eq true
      expect(piece.valid_move?(1,2)).to eq true
      expect(piece.valid_move?(1,4)).to eq true
    end
  end
end
