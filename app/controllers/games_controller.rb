class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
  end

  def show
    #@game = Game.find(params[:id])
  end


end
