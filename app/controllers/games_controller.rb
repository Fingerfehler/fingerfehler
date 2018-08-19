class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_turn, only: [:castle_kingside, :castle_queenside]
  skip_before_action :verify_authenticity_token

  def index
    @gamesAll = Game.all
    @games = Game.available
    if current_user.present?
      @my_games = Game.mine(current_user)
    end
  end

  def update
    @game = Game.find(params[:id])
    @game.black_player_id = current_user.id
    @game.save
    render :show 
  end

  def make_move
    @game = Game.find(params[:game_id])
    @pieces = @game.pieces
    piece_to_move = Piece.find(params[:piece_id].to_i)
    x = params[:x].to_i
    y = params[:y].to_i
    if piece_to_move.valid_move?(x, y)
      piece_to_move.move_to!(x, y)
      status = 202
    else
      status = 422
    end
    head status 
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.white_player_id = current_user.id
    @game.save
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def castle_kingside
    @game = Game.find(params[:game_id])
    if @game.can_kingside_castle?(current_user)
      @game.kingside_castle!(current_user)
      @game.take_turn!
    else
      flash.now[:alert] = "You cannot castle at this time."
    end
    render :show
  end

  def castle_queenside
    @game = Game.find(params[:game_id])
    if @game.can_queenside_castle?(current_user)
      @game.queenside_castle!(current_user)
      @game.take_turn!
    else
      flash.now[:alert] = "You cannot castle at this time."
    end
    render :show
  end

  def destroy
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    @game.destroy
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_player_id)
  end

  def authenticate_turn
    unless white_logged_in_and_white_turn? || black_logged_in_and_black_turn?
      flash.now[:alert] = "It's not your turn."
      render :show
    end
  end

  def white_logged_in_and_white_turn?
    @game = Game.find(params[:game_id])
    @game.white_turn? && current_user.id == @game.white_player.id
  end

  def black_logged_in_and_black_turn?
    @game = Game.find(params[:game_id])
    @game.black_turn? && current_user.id == @game.black_player.id
  end

end

