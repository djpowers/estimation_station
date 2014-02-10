class JarsController < ApplicationController

  def index
    @jars = Jar.all
  end

  def show
    @jar = Jar.find(params[:id])
  end

  def new
    @jar = Jar.new
    @game = Game.find(params[:game_id])
  end

  def create
    @jar = Jar.new(jar_params)
    @game = Game.find(params[:game_id])
    @jar.game_id = @game.id

    if @jar.save
      flash[:notice] = 'Jar was successfully created. Thanks for bringing it!'
      redirect_to game_jar_path(@game, @jar)
    else
      puts 'There was an error!'
      render :new
    end
  end

  private

    def jar_params
      params.require(:jar).permit(:contents, :quantity, :player_id)
    end

end
