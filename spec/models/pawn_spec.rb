require 'rails_helper'

RSpec.describe Pawn, type: :model do

  let(:user) { FactoryBot.build(:user) }
  let(:game) { FactoryBot.build(:game, white_player: user) }
  let(:white_pawn) { FactoryBot.build(:pawn, x_coord: white_1_x, y_coord: white_1_y, white?: true, game: game) }
  let(:white_pawn_2) { FactoryBot.build(:pawn, x_coord: white_2_x, y_coord: white_2_y, white?: true, game: game) }
  let(:black_pawn) { FactoryBot.build(:pawn, x_coord: black_1_x, y_coord: black_1_y, white?: false, game: game) }
  let(:black_pawn_2) { FactoryBot.build(:pawn, x_coord: black_2_x, y_coord: black_2_y, white?: false, game: game) }

  describe "#valid_move?" do

    let(:white_1_x) { 3 }
    let(:white_1_y) { 1 }

    let(:black_1_x) { 4 }
    let(:black_1_y) { 6 }

    describe "standard pawn movement" do

      it "should be valid" do
        aggregate_failures do
          expect(white_pawn.valid_move?(3,2)).to eq true
          expect(black_pawn.valid_move?(4,5)).to eq true
        end
      end

      it "should be invalid if an ally piece is in the way" do
        let(:white_2_x) { 3 }
        let(:white_2_y) { 2 }

        let(:black_2_x) { 4 }
        let(:black_2_y) { 5 }
        aggregate_failures do
          expect(white_pawn.valid_move?(3,2)).to eq false
          expect(black_pawn.valid_move?(4,5)).to eq false
        end
      end

    end

    describe "two square pawn movement" do

      it "should be valid when pawn hasn't moved" do
        aggregate_failures do
          expect(white_pawn.valid_move?(3,3)).to eq true
          expect(black_pawn.valid_move?(4,4)).to eq true
        end
      end

      it "should be invalid after pawn has moved" do
        white_pawn.move_to!(3,2)
        black_pawn.move_to!(4,5)
        aggregate_failures do
          expect(white_pawn.valid_move?(3,4)).to eq false
          expect(black_pawn.valid_move?(4,3)).to eq false
        end
      end

    describe "pawn capture movement" do

      it "should be valid to capture opponent piece" do
        let(:white_2_x) { 3 }
        let(:white_2_y) { 5 }

        let(:black_2_x) { 4 }
        let(:black_2_y) { 2 }
        aggregate_failures do 
          expect(white_pawn.valid_move?(4,2)).to eq true
          expect(black_pawn.valid_move?(3,5)).to eq true
        end
      end

      it "should be invalid to capture own piece" do
        let(:white_2_x) { 4 }
        let(:white_2_y) { 2 }
        let(:black_2_x) { 3 }
        let(:black_2_y) { 5 }
        aggregate_failures do
          expect(white_pawn.valid_move?(4,2)).to eq false
          expect(black_pawn.valid_move?(3,5)).to eq false
        end
      end

    end

  end
end
