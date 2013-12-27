class JarsController < ApplicationController

  def index
    @jars = Jar.all
  end

  def show
    @jar = Jar.find(params[:id])
  end

  def new
    @jar = Jar.new
  end

  def create
    @jar = Jar.new(jar_params)

    if @jar.save
      redirect_to @jar, notice: 'Jar was successfully created. Thanks for bringing it!'
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
