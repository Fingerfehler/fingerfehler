require 'rails_helper'

RSpec.describe Bishop, type: :model do

  describe "is_valid_move bishop" do 
    it "should be an invalid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Bishop.create(:x_coord => 3, :y_coord => 3, :game_id => game.id)
      expect(piece.valid_move?(3,4)).to eq false
      expect(piece.valid_move?(3,2)).to eq false
      expect(piece.valid_move?(2,3)).to eq false
      expect(piece.valid_move?(4,3)).to eq false
      expect(piece.valid_move?(2,5)).to eq false
      expect(piece.valid_move?(5,6)).to eq false
      expect(piece.valid_move?(7,0)).to eq false
      expect(piece.valid_move?(0,3)).to eq false
      expect(piece.valid_move?(3,0)).to eq false
    end
  end
  describe "is_valid_move bishop" do 
    it "should be valid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Bishop.create(:x_coord => 3, :y_coord => 3, :game_id => game.id)
      
      expect(piece.valid_move?(0,0)).to eq true
      expect(piece.valid_move?(1,1)).to eq true
      expect(piece.valid_move?(2,2)).to eq true
      expect(piece.valid_move?(4,4)).to eq true
      expect(piece.valid_move?(5,5)).to eq true
      expect(piece.valid_move?(6,6)).to eq true
      expect(piece.valid_move?(7,7)).to eq true
      expect(piece.valid_move?(6,0)).to eq true
      expect(piece.valid_move?(5,1)).to eq true    
      expect(piece.valid_move?(4,2)).to eq true
      expect(piece.valid_move?(2,4)).to eq true
      expect(piece.valid_move?(1,5)).to eq true
      expect(piece.valid_move?(0,6)).to eq true
    end
  end

end
