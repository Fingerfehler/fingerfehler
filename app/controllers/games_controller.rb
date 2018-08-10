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
    if @game.can_kingside_castle?(current_user)
      @game.kingside_castle!(current_user)
    else
      flash.now[:alert] = "You cannot castle at this time."
    end
    render :show
  end

  def castle_queenside
    @game = Game.find(params[:game_id])
    if @game.can_queenside_castle?(current_user)
      @game.queenside_castle!(current_user)
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

end