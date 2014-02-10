class GuessesController < ApplicationController

  def index
    @guesses = Guess.all
  end

  def show
    @guess = Guess.find(params[:id])
  end

  def new
    @guess = Guess.new
    @game = Game.find(params[:game_id])
  end

  def create
    @guess = Guess.new(guess_params)
    @game = Game.find(params[:game_id])

    if @guess.save
      flash[:notice] = 'Guess was successfully created. Thanks for playing!'
      redirect_to game_path(@game)
    else
      puts 'There was an error!'
      render :new
    end
  end

  private

    def guess_params
      params.require(:guess).permit(:quantity, :player_id, :jar_id, :game_id)
    end

end
