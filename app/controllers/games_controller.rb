class GamesController < ApplicationController

  def index
    @games = Game.available
    @currentUser = current_user.id
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
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_player_id)
  end

end
