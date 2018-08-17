require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "#valid_move?" do
    describe "standard pawn movement" do
      it "should be invalid for backwards move" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0)
        expect(white_pawn.valid_move?(3,0)).to eq false
        expect(black_pawn.valid_move?(4,7)).to eq false
      end
      it "should be valid for move 1" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0)
        expect(white_pawn.valid_move?(3,2)).to eq true
        expect(black_pawn.valid_move?(4,5)).to eq true
      end
      it "should be valid for move 2" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0)
        expect(white_pawn.valid_move?(3,3)).to eq true
        expect(black_pawn.valid_move?(4,4)).to eq true
      end
      it "should be invalid to move 2 if piece has moved?" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0)
        white_pawn.move_to!(3,2)
        black_pawn.move_to!(4,5)
        expect(white_pawn.valid_move?(3,4)).to eq false
        expect(black_pawn.valid_move?(4,3)).to eq false
      end
    end
    describe "capture movement" do
      it "should be valid to capture opponent piece" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 2, :white? => false, :game_id => game.id, :move_count => 0)
        black_pawn2 = Pawn.create(:x_coord => 2, :y_coord => 2, :white? => false, :game_id => game.id, :move_count => 0) 
        black_pawn3 = Pawn.create(:x_coord => 3, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0) 
        white_pawn2 = Pawn.create(:x_coord => 4, :y_coord => 5, :white? => true, :game_id => game.id, :move_count => 0) 
        white_pawn3 = Pawn.create(:x_coord => 2, :y_coord => 5, :white? => true, :game_id => game.id, :move_count => 0)
        expect(white_pawn.valid_move?(4,2)).to eq true
        expect(white_pawn.valid_move?(2,2)).to eq true
        expect(black_pawn3.valid_move?(4,5)).to eq true
        expect(black_pawn3.valid_move?(2,5)).to eq true
      end
    end
    describe "self capture movement" do
      it "should be invalid to capture own piece" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        white_pawn2 = Pawn.create(:x_coord => 4, :y_coord => 2, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 3, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0)
        black_pawn2 = Pawn.create(:x_coord => 4, :y_coord => 5, :white? => false, :game_id => game.id, :move_count => 0)
        expect(white_pawn.valid_move?(4,2)).to eq false
        expect(black_pawn.valid_move?(4,5)).to eq false
      end
    end
    describe "en passant capture white" do
      it "should be valid black capture white" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        white_pawn2 = Pawn.create(:x_coord => 5, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 3, :white? => false, :game_id => game.id, :move_count => 2)
        white_pawn.move_to!(3,3)
        white_pawn2.move_to!(5,3)
        white_pawn.save!
        white_pawn2.save!
        expect(black_pawn.can_capture_en_passant?(3,3)).to eq true
        expect(black_pawn.can_capture_en_passant?(5,3)).to eq true
      end
    end
    describe "en passant capture black" do
      it "should be valid white capture black" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id)
        game.pieces.destroy_all
        black_pawn = Pawn.create(:x_coord => 3, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0)
        black_pawn2 = Pawn.create(:x_coord => 5, :y_coord => 6, :white? => false, :game_id => game.id, :move_count => 0)
        white_pawn = Pawn.create(:x_coord => 4, :y_coord => 4, :white? => true, :game_id => game.id, :move_count => 2)
        black_pawn.move_to!(3,4)
        black_pawn.save!
        black_pawn.game.save!
        game.reload
        black_pawn2.move_to!(5,4)   
        black_pawn2.save!
        game.reload
        expect(white_pawn.can_capture_en_passant?(3,4)).to eq true
        expect(white_pawn.can_capture_en_passant?(5,4)).to eq true
      end
    end
    describe "en passant invalid capture" do
      it "should be invalid to capture if not opponents first move" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id, :turn => 0)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id, :move_count => 0)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 3, :white? => false, :game_id => game.id, :move_count => 2)
        white_pawn.move_to!(3,2)
        white_pawn.save!
        white_pawn.game.save!
        game.reload
        white_pawn.move_to!(3,3)
        white_pawn.save!
        white_pawn.game.save!
        game.reload
        expect(black_pawn.can_capture_en_passant?(3,3)).to eq false
      end
    end

  end
end
