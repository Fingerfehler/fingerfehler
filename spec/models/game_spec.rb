require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "populate_game! method" do
    it "should populate a new game after creation with 32 pieces" do
      game = Game.create
      expect(game.pieces.length).to eq 32
    end
    it "should populate a new game with the queens at (3,0) and (3,7)" do
      game = Game.create
      w_queen = game.pieces.where(:type => 'Queen', :white? => true).first
      b_queen = game.pieces.where(:type => 'Queen', :white? => false).first
      expect([w_queen.x_coord, w_queen.y_coord]).to eq [3,0]
      expect([b_queen.x_coord, b_queen.y_coord]).to eq [3,7]
    end
  end
  describe "is in_check?" do
    it "should check if white king is in check" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      white_king = King.create(:x_coord => 4, :y_coord => 3, :game_id => game.id, :white? => true)
      black_king = King.create(:x_coord => 4, :y_coord => 7, :game_id => game.id, :white? => false)
      black_rook = Rook.create(:x_coord => 0, :y_coord => 3, :game_id => game.id, :white? => false)
      black_queen = Queen.create(:x_coord => 2, :y_coord => 5, :game_id => game.id, :white? => false)
      black_bishop = Bishop.create(:x_coord => 5, :y_coord => 4, :game_id => game.id, :white? => false)
      game.reload
      expect(game.in_check?).to eq true
    end
  end
  describe "is not in_check?" do
    it "should check if white king is in check" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      white_king = King.create(:x_coord => 4, :y_coord => 2, :game_id => game.id, :white? => true)
      black_king = King.create(:x_coord => 4, :y_coord => 7, :game_id => game.id, :white? => false)
      black_rook = Rook.create(:x_coord => 0, :y_coord => 3, :game_id => game.id, :white? => false)
      black_queen = Queen.create(:x_coord => 2, :y_coord => 5, :game_id => game.id, :white? => false)
      black_bishop = Bishop.create(:x_coord => 5, :y_coord => 4, :game_id => game.id, :white? => false)
      game.reload
      expect(game.in_check?).to eq false
    end
  end
    describe "is in_check?" do
    it "should check if black king is in check" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      black_king = King.create(:x_coord => 4, :y_coord => 3, :game_id => game.id, :white? => false)
      white_king = King.create(:x_coord => 4, :y_coord => 7, :game_id => game.id, :white? => true)
      white_rook = Rook.create(:x_coord => 0, :y_coord => 3, :game_id => game.id, :white? => true)
      white_queen = Queen.create(:x_coord => 2, :y_coord => 5, :game_id => game.id, :white? => true)
      white_bishop = Bishop.create(:x_coord => 5, :y_coord => 4, :game_id => game.id, :white? => true)
      game.reload
      expect(game.in_check?).to eq true
    end
  end
  describe "is not in_check?" do
    it "should check if black king is in check" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      black_king = King.create(:x_coord => 4, :y_coord => 2, :game_id => game.id, :white? => false)
      white_king = King.create(:x_coord => 4, :y_coord => 7, :game_id => game.id, :white? => true)
      white_rook = Rook.create(:x_coord => 0, :y_coord => 3, :game_id => game.id, :white? => true)
      white_queen = Queen.create(:x_coord => 2, :y_coord => 5, :game_id => game.id, :white? => true)
      white_bishop = Bishop.create(:x_coord => 5, :y_coord => 4, :game_id => game.id, :white? => true)
      game.reload
      expect(game.in_check?).to eq false
    end
  end
  describe "game#can_kingside_castle?" do
    it "should be true if white can castle" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      white_king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :white? => true, :move_count => 0)
      white_rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :white? => true, :move_count => 0)
      expect(game.can_kingside_castle?(user)).to eq true
    end
  end
  describe "game#kingside_castle!" do 
    it "should place pieces correctly" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      white_king = King.create(:x_coord => 4, :y_coord => 0, :game_id => game.id, :white? => true, :move_count => 0)
      white_rook = Rook.create(:x_coord => 7, :y_coord => 0, :game_id => game.id, :white? => true, :move_count => 0)
      game.kingside_castle!(user)
      white_king.reload
      white_rook.reload
      expect(white_king.x_coord).to eq 6
      expect(white_rook.x_coord).to eq 5
    end
  end
end
