require 'rails_helper'

RSpec.describe Rook, type: :model do

  describe "is_valid_move rook" do 
    it "should be an invalid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Rook.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      expect(piece.valid_move?(3,3)).to eq false
      expect(piece.valid_move?(1,1)).to eq false
      expect(piece.valid_move?(4,3)).to eq false
      expect(piece.valid_move?(5,1)).to eq false
    end
  end
  describe "is_valid_move rook" do 
    it "should be valid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Rook.create(:x_coord => 0, :y_coord => 7, :game_id => game.id)
      expect(piece.valid_move?(0,2)).to eq true
      expect(piece.valid_move?(4,7)).to eq true
      expect(piece.valid_move?(0,1)).to eq true
      expect(piece.valid_move?(2,7)).to eq true
      expect(piece.valid_move?(1,7)).to eq true
    end
  end

  describe "rook#can_castle?" do
    it "should be valid if conditions are met" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :move_count => 0)
      rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :move_count => 0)
      aggregate_failures do
        expect(rook.can_castle?).to eq true
      end
    end
    it "should be invalid if conditions aren't met" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      pawn = Pawn.create(:x_coord => 4, :y_coord => 0, :game_id => game.id)
      rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id)
      aggregate_failures do
        expect(rook.can_castle?).to eq false
      end
    end
  end

  describe "rook#castle!" do
    it "should place black queenside rook correctly" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      king = King.create(:x_coord => 4, :y_coord => 7, :game_id => game.id, :move_count => 0)
      rook = Rook.create(:x_coord => 0, :y_coord => 7, :game_id => game.id, :move_count => 0)
      rook.castle!
      aggregate_failures do
        expect(rook.x_coord).to eq 3
        expect(rook.y_coord).to eq 7
      end
    end
  end

end
