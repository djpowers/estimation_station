class PlayersController < ApplicationController

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
    @group = Group.find(params[:group_id])
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:notice] = 'Player was successfully added.'
      redirect_to player_path(@player)
    else
      @group = Group.find(@player.group_id)
      flash[:notice] = 'There was an error!'
      render :new
    end
  end

  private

    def player_params
      params.require(:player).permit(:name, :group_id)
    end

end
