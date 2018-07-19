require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_vertically_obstructed?" do 
    it "should find vertical obstructions" do
      user = User.create(:id => 1)
      game = Game.create(:id => 1, :name => "test", :white_player_id => user.id)
      b_rook = Piece.create(:x_coord => 0, :y_coord => 0, :game_id => game.id)
      obstructed_piece = Piece.create(:x_coord => 0, :y_coord => 1, :game_id => game.id)
      expect(b_rook.is_vertically_obstructed?(0,4)).to eq true
    end
  end

end
