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
      flash[:notice] = 'Player was successfully added.'
      redirect_to player_path(@player)
    else
      flash[:notice] = 'There was an error!'
      render :new
    end
  end

  private

    def player_params
      params.require(:player).permit(:name)
    end

end
