class PiecesController < ApplicationController

  def create
    @Piece = Piece.create(piece_params)
  end

  def show
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @pieces = @game.pieces
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    puts "PIECE ID BOY:" + params[:id]
    redirect_to game_pieces_path
  end

end
