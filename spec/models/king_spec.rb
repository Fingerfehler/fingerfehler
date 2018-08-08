require 'rails_helper'

RSpec.describe King, type: :model do

  describe "is_valid_move king" do 
    it "should be an invalid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = King.create(:x_coord => 3, :y_coord => 0, :game_id => game.id)
      expect(piece.valid_move?(3,3)).to eq false
      expect(piece.valid_move?(1,1)).to eq false
      expect(piece.valid_move?(4,3)).to eq false
      expect(piece.valid_move?(5,1)).to eq false
      expect(piece.valid_move?(3,-1)).to eq false
      expect(piece.valid_move?(99,-10)).to eq false
    end
  end
  describe "is_valid_move king" do 
    it "should be valid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = King.create(:x_coord => 3, :y_coord => 1, :game_id => game.id)
      expect(piece.valid_move?(3,2)).to eq true
      expect(piece.valid_move?(4,1)).to eq true
      expect(piece.valid_move?(4,0)).to eq true
      expect(piece.valid_move?(2,2)).to eq true
      expect(piece.valid_move?(2,0)).to eq true
    end
  end
  describe "move into check" do
    it "should be invalid to move into check" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      white_king = King.create(:x_coord => 3, :y_coord => 1, :game_id => game.id, :white? => true, :move_count => 0)
      black_queen = Queen.create(:x_coord => 0, :y_coord => 2, :game_id => game.id, :white? => false, :move_count => 0)
      expect(white_king.self_in_check?(3,2)).to eq true
    end
  end

end
