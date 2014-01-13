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
    @group = Group.find(params[:group_id])
    @player.group_id = @group.id

    if @player.save
      flash[:notice] = 'Player was successfully added.'
      redirect_to group_player_path(@group, @player)
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
