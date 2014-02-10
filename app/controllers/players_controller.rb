class PlayersController < ApplicationController

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
    @game = Game.find(params[:game_id])
  end

  def create
    @player = Player.new(player_params)
    @game = Game.find(params[:game_id])
    @player.game_id = @game.id

    if @player.save
      flash[:notice] = 'Player was successfully added.'
      redirect_to game_player_path(@game, @player)
    else
      flash[:notice] = 'There was an error!'
      render :new
    end
  end

  private

    def player_params
      params.require(:player).permit(:name, :game_id)
    end

end
