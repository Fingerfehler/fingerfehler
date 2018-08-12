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
    @piece.x_coord = params[:x_coord]
    @piece.y_coord = params[:y_coord]
    @piece.save
    @piece.game.take_turn!
    @piece.game.save
    redirect_to game_path(@piece.game)
  end

  private



end
