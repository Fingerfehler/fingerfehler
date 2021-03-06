require 'rails_helper'

RSpec.describe King, type: :model do

  describe "is_valid_move king" do 
    it "should be an invalid movement" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      piece = King.create(:x_coord => 4, :y_coord => 7, :game_id => game.id)
      aggregate_failures do
        expect(piece.valid_move?(4,2)).to eq false
        expect(piece.valid_move?(3,3)).to eq false
        expect(piece.valid_move?(1,1)).to eq false
        expect(piece.valid_move?(4,3)).to eq false
        expect(piece.valid_move?(5,1)).to eq false
        expect(piece.valid_move?(3,-1)).to eq false
        expect(piece.valid_move?(99,-10)).to eq false
      end
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
  describe "king#can_castle?" do
    it "should be valid if conditions are met" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :move_count => 0)
      rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :move_count => 0)
      aggregate_failures do 
        expect(king.can_castle?(7,0)).to eq true
      end
    end
    it "should be invalid if king has moved" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :move_count => 0)
      rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :move_count => 0)
      king.move_to!(3,1)
      king.move_to!(3,0)
      aggregate_failures do
        expect(king.can_castle?(7,0)).to eq false
      end
    end
    it "should be invalid if rook has moved" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :white? => true, :move_count => 0)
      rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :white? => true, :move_count => 0)
      rook.move_to!(7,1)
      rook.move_to!(7,0)
      aggregate_failures do
        expect(king.can_castle?(7,0)).to eq false
      end
    end
    it "should be invalid if there is an obstruction" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :move_count => 0)
      rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :move_count => 0)
      bishop = Bishop.create(:x_coord => 5, :y_coord => 0, :game_id => game.id)
      aggregate_failures do
        expect(king.can_castle?(7,0)).to eq false
      end
    end
  end
  describe "king#castle!" do
    it "should place the king in the correct spot" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :move_count => 0)
      rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :move_count => 0)
      king.castle!(7,0)
      aggregate_failures do
        expect(king.x_coord).to eq 6
        expect(king.y_coord).to eq 0
      end
    end
  end
  describe "move into check" do
    it "should be invalid to move into check" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      white_king = King.create(:x_coord => 3, :y_coord => 1, :game_id => game.id, :white? => true, :move_count => 0)
      black_queen = Queen.create(:x_coord => 0, :y_coord => 2, :game_id => game.id, :white? => false, :move_count => 0)
      black_king = King.create(:x_coord => 4, :y_coord => 6, :game_id => game.id, :white? => true, :move_count => 0)
      white_queen = Queen.create(:x_coord => 7, :y_coord => 5, :game_id => game.id, :white? => false, :move_count => 0)
      expect(white_king.safe?(3,2)).to eq false
      expect(white_king.valid_move?(3,2)).to eq false
      expect(black_king.safe?(4,5)).to eq false
      expect(black_king.valid_move?(4,5)).to eq false
    end
  end

end
