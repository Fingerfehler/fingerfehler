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

  describe "game in checkmate?" do
    it "should be be true if game is in checkmate" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      black_king = King.create(:x_coord => 2, :y_coord => 1, :game_id => game.id, :white? => false)
      white_rook = Rook.create(:x_coord => 0, :y_coord => 2, :game_id => game.id, :white? => true)
      white_rook2 = Rook.create(:x_coord => 0, :y_coord => 1, :game_id => game.id, :white? => true)
      white_rook3 = Rook.create(:x_coord => 0, :y_coord => 0, :game_id => game.id, :white? => true)     
      white_king = King.create(:x_coord => 5, :y_coord => 6, :game_id => game.id, :white? => true)
      black_rook = Rook.create(:x_coord => 7, :y_coord => 5, :game_id => game.id, :white? => false)
      black_rook2 = Rook.create(:x_coord => 7, :y_coord => 6, :game_id => game.id, :white? => false)
      black_rook3 = Rook.create(:x_coord => 7, :y_coord => 7, :game_id => game.id, :white? => false)      
      game.reload
      expect(game.checkmate?).to eq true
    end
  end

  describe "game in stalemate?" do
    it "should be be true if game is in stalemate" do
      user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
      game = Game.create(:name => "test", :white_player_id => user.id)
      game.pieces.destroy_all
      black_king = King.create(:x_coord => 2, :y_coord => 1, :game_id => game.id, :white? => false)
      white_rook = Rook.create(:x_coord => 0, :y_coord => 1, :game_id => game.id, :white? => true)
      white_rook2 = Rook.create(:x_coord => 3, :y_coord => 2, :game_id => game.id, :white? => true)
      white_king = King.create(:x_coord => 5, :y_coord => 6, :game_id => game.id, :white? => true)
      black_rook = Rook.create(:x_coord => 4, :y_coord => 7, :game_id => game.id, :white? => false)
      black_rook2 = Rook.create(:x_coord => 6, :y_coord => 5, :game_id => game.id, :white? => false)
      game.reload
      expect(game.stalemate?).to eq true
    end
  end

end
