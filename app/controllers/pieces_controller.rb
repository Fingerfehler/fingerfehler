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
    @piece.move_to!(params[:x_coord],params[:y_coord])
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
    unless piece_is_color_of_logged_in_user?
      flash.now[:alert] = "You can only move your own pieces."
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

  def piece_is_color_of_logged_in_user?
    @piece = Piece.find_by_id(params[:id])
    logged_in_user_is_white = current_user.id == @piece.game.white_player.id
    piece_is_white_and_player_is_white = @piece.white? == logged_in_user_is_white
    logged_in_user_is_black = current_user.id == @piece.game.black_player.id
    piece_is_black_and_player_is_black = !@piece.white? == logged_in_user_is_black
    return piece_is_black_and_player_is_black || piece_is_white_and_player_is_white
  end

end
