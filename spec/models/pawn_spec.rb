require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "valid_move? method" do
    it "should identify standard pawn moves as valid" do
      game = Game.create
      w_pawn = game.pieces.where(:x_coord => 2, :y_coord => 1).first
      b_pawn = game.pieces.where(:x_coord => 3, :y_coord => 6).first
      expect(w_pawn.valid_move?(2,2)).to eq true
      expect(w_pawn.valid_move?(2,3)).to eq true
      expect(b_pawn.valid_move?(3,5)).to eq true
      expect(b_pawn.valid_move?(3,4)).to eq true
      w_pawn.move_to(2, 3)
      b_pawn.move_to(3, 4)
      expect(w_pawn.valid_move?(2,4)).to eq true
      expect(w_pawn.valid_move?(2,5)).to eq false
      expect(b_pawn.valid_move?(3,3)).to eq true
      expect(b_pawn.valid_move?(3,2)).to eq false
      b_pawn2 = game.pieces.where(:x_coord => 2, :y_coord => 6).first
      b_pawn2.move_to(2, 4)
      expect(w_pawn.valid_move?(2,4)).to eq false
      expect(w_pawn.valid_move?(3,4)).to eq true
    end
  end

end
