require 'rails_helper'

RSpec.describe Piece, type: :model do

  describe "is_vertically_obstructed?" do 
    it "should find vertical obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Piece.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 0, :y_coord => 1, :game_id => game.id)
      expect(piece.is_vertically_obstructed?(0,4)).to eq true
      expect(piece.is_vertically_obstructed?(4,0)).to eq false
    end
  end
  describe "is_horizontally_obstructed?" do 
    it "should find horizontal obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Piece.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 1, :y_coord => 0, :game_id => game.id)
      expect(piece.is_horizontally_obstructed?(4,0)).to eq true
      expect(piece.is_horizontally_obstructed?(0,4)).to eq false
    end
  end
  describe "is_diagonally_obstructed?" do 
    it "should find diagonal obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Piece.create(:x_coord => 1, :y_coord => 1, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 2, :y_coord => 2, :game_id => game.id)
      expect(piece.is_diagonally_obstructed?(4,4)).to eq true
      expect(piece.is_diagonally_obstructed?(0,0)).to eq false
    end
  end
  describe "is_obstructed?" do 
    it "should find obstructions" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Piece.create(:x_coord => 2, :y_coord => 2, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 3, :y_coord => 3, :game_id => game.id)
      expect(piece.is_obstructed?(1,5)).to eq 'invalid input square'
      expect(piece.is_obstructed?(4,4)).to eq true
      expect(piece.is_obstructed?(1,1)).to eq false
    end
  end
  describe "move_to empty square" do
    it "should update piece with new coords" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Piece.create(:x_coord => 4, :y_coord => 4, :game_id => game.id)
      piece.move_to!(5,5)
      expect(piece.x_coord).to eq 5
      expect(piece.y_coord).to eq 5 
    end
  end
  describe "move_to square with same color piece" do 
    it "should not update new coords" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Piece.create(:x_coord => 4, :y_coord => 4, :game_id => game.id, :white? => true)
      same_color_piece = Piece.create(:x_coord => 5, :y_coord => 5, :game_id => game.id, :white? => true)
      black_piece = Piece.create(:x_coord => 1, :y_coord => 1, :game_id => game.id, :white? => false)
      black_same_color_piece = Piece.create(:x_coord => 2, :y_coord => 2, :game_id => game.id, :white? => false)
      piece.move_to!(5,5)
      black_piece.move_to!(2,2)
      expect(piece.x_coord).to eq 4
      expect(piece.y_coord).to eq 4
      expect(black_piece.x_coord).to eq 1
      expect(black_piece.y_coord).to eq 1
    end
  end
  describe "move_to and capture piece" do
    it "should update piece coord and remove captured piece" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = Piece.create(:x_coord => 4, :y_coord => 4, :game_id => game.id, :white? => true, :captured? => false)
      black_piece = Piece.create(:x_coord => 5, :y_coord => 5, :game_id => game.id, :white? => false, :captured? => false)
      piece.move_to!(5,5)
      black_piece.reload
      piece.reload
      expect(black_piece.x_coord).to eq 8
      expect(black_piece.y_coord).to eq 8
      expect(black_piece.capture!).to eq true
      expect(piece.x_coord).to eq 5
      expect(piece.y_coord).to eq 5
    end
  end
end




