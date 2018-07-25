class PiecesController < ApplicationController

  def create
    @Piece = Piece.create(piece_params)
  end

  def show
    @piece = Piece.find_by_id(params[:x_coord && :y_coord])
    @game = @piece.game
    @pieces = [@piece]
  end


end
