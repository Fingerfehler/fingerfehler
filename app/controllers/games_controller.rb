class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    x = params[:x]
    y = params[:y]
    if piece_to_move.valid_move?(x, y)
      piece_to_move.move_to!(x, y)
    else

    end
    render :show
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

  #def update
  #  @game = Game.find(params[:id])
  #  @pieces = @game.pieces
  #end

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

end