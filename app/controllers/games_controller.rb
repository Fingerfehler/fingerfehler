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

  def update
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def castle_kingside
    @game = Game.find(params[:game_id])
    y = @game.white_player_id == current_user.id ? 0 : 7
    @king = @game.pieces.find_by(:x_coord => 4, :y_coord => y) 
    if @king && @king.can_castle?(7,y)
      @rook = @game.pieces.find_by(:x_coord => 7, :y_coord => y)
      @king.castle!(7,y)
      @rook.castle!
      render :show
    else
      flash.now[:alert] = "You cannot castle at this time."
      render :show
    end
  end

  def castle_queenside
    @game = Game.find(params[:game_id])
    y = @game.white_player_id == current_user.id ? 0 : 7
    @king = @game.pieces.find_by(:x_coord => 4, :y_coord => y)
    if @king && @king.can_castle?(0,y)
      @rook = @game.pieces.find_by(:x_coord => 0, :y_coord => y)
      @king.castle!(0,y)
      @rook.castle!
      render :show
    else
      flash.now[:alert] = "You cannot castle at this time."
      render :show
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_player_id)
  end

end