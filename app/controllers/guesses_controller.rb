class GuessesController < ApplicationController

  def index
    @guesses = Guess.all
  end

  def show
    @guess = Guess.find(params[:id])
  end

  def new
    @guess = Guess.new
    @group = Group.find(params[:group_id])
  end

  def create
    @guess = Guess.new(guess_params)
    @group = Group.find(params[:group_id])
    # @guess.group_id = @group.id

    if @guess.save
      flash[:notice] = 'Guess was successfully created. Thanks for playing!'
      redirect_to group_path(@group)
    else
      puts 'There was an error!'
      render :new
    end
  end

  private

    def guess_params
      params.require(:guess).permit(:quantity, :player_id, :jar_id, :group_id)
    end

end
