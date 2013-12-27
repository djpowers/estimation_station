class PlayersController < ApplicationController

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: 'Player was successfully created. Good luck!'
    else
      puts 'There was an error!'
      render :new
    end
  end

  private

    def player_params
      params.require(:player).permit(:name)
    end

end
