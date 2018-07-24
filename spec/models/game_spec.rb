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
end
