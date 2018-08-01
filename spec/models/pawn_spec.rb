require 'rails_helper'

RSpec.describe Pawn, type: :model do

  describe "#valid_move?" do

    describe "standard pawn movement" do

      it "should be valid for move 1" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id)
        aggregate_failures do
          expect(white_pawn.valid_move?(3,2)).to eq true
        end
      end

      it "should be valid for move 2" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id)
        aggregate_failures do
          expect(white_pawn.valid_move?(3,3)).to eq true
        end
      end

      it "should be invalid to move 2 if has_moved?" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id)
        white_pawn.update_attributes(:x_coord => 3, :y_coord => 2)
        aggregate_failures do

          expect(white_pawn.valid_move?(3,4)).to eq false
        end
      end

    end

    describe "blocked pawn movement" do

      it "should be invalid if an ally piece is in the way" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id)
        white_pawn2 = Pawn.create(:x_coord => 3, :y_coord => 2, :white? => true, :game_id => game.id)
        aggregate_failures do
          expect(white_pawn.valid_move?(3,2)).to eq false
        end
      end

    end

    describe "capture movement" do

      it "should be valid to capture opponent piece" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id)
        black_pawn = Pawn.create(:x_coord => 4, :y_coord => 2, :white? => false, :game_id => game.id)
        aggregate_failures do 
          expect(white_pawn.valid_move?(4,2)).to eq true
        end
      end

    end

    describe "self capture movement" do

      it "should be invalid to capture own piece" do
        user = User.create(:email => "fakeemail@email", :password => "secret", :password_confirmation => "secret")
        game = Game.create(:name => "test", :white_player_id => user.id)
        game.pieces.destroy_all
        white_pawn = Pawn.create(:x_coord => 3, :y_coord => 1, :white? => true, :game_id => game.id)
        white_pawn2 = Pawn.create(:x_coord => 4, :y_coord => 2, :white? => true, :game_id => game.id)
        aggregate_failures do
          expect(white_pawn.valid_move?(4,2)).to eq false
        end
      end

    end

  end
end
