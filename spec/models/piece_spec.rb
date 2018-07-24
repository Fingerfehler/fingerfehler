require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_vertically_obstructed?" do 
    it "should find vertical obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      piece = Piece.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 0, :y_coord => 1, :game_id => game.id)
      expect(piece.is_vertically_obstructed?(0,4)).to eq true
    end
  end
  describe "is_horizontally_obstructed?" do 
    it "should find horizontal obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      piece = Piece.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 1, :y_coord => 0, :game_id => game.id)
      expect(piece.is_horizontally_obstructed?(4,0)).to eq true
    end
  end
  describe "is_diagonally_obstructed?" do 
    it "should find diagonal obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      piece = Piece.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 1, :y_coord => 1, :game_id => game.id)
      expect(piece.is_diagonally_obstructed?(4,4)).to eq true
    end
  end
  describe "is_obstructed?" do 
    it "should find obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      piece = Piece.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 1, :y_coord => 1, :game_id => game.id)
      expect(piece.is_obstructed?(1,5)).to eq 'invalid input square'
    end
  end
end
