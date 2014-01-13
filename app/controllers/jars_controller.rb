class JarsController < ApplicationController

  def index
    @jars = Jar.all
  end

  def show
    @jar = Jar.find(params[:id])
  end

  def new
    @jar = Jar.new
    @group = Group.find(params[:group_id])
  end

  def create
    @jar = Jar.new(jar_params)
    @group = Group.find(params[:group_id])
    @jar.group_id = @group.id

    if @jar.save
      flash[:notice] = 'Jar was successfully created. Thanks for bringing it!'
      redirect_to group_jar_path(@group, @jar)
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
