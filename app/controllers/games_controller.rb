class GamesController < ApplicationController

  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user

    if @game.save
      flash[:notice] = 'Game was successfully created.'
      redirect_to game_path(@game)
    else
      flash[:notice] = 'There was an error'
      render 'new'
    end
  end

  def show
    @game = Game.find(params[:id])
    @players = @game.players
    @jars = @game.jars
  end

  def index
    @games = current_user.games
  end

  private

    def game_params
      params.require(:game).permit(:title)
    end

end
