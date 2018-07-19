class GamesController < ApplicationController
  def new
    @game = Game.new

  end

  def create
    @game = Game.create(game_params)
  end

  def show
    @game = Game.find(params[:id])
    
  end


end
