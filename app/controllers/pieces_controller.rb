class PiecesController < ApplicationController

  def create
    @Piece = Piece.create(piece_params)
  end


end
