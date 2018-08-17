class PiecesController < ApplicationController
  before_action :authenticate_turn, only: [:update]

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

  def authenticate_turn
    unless white_logged_in_and_white_turn? || black_logged_in_and_black_turn?
      flash.now[:alert] = "It's not your turn."
      render 'games/show'
    end
  end

  def white_logged_in_and_white_turn?
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @game.white_turn? && current_user.id == @game.white_player.id
  end

  def black_logged_in_and_black_turn?
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @game.black_turn? && current_user.id == @game.black_player.id
  end



end
