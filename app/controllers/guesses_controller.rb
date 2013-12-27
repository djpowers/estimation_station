class GuessesController < ApplicationController

  def index
    @guesses = Guess.all
  end

  def show
    @guess = Guess.find(params[:id])
  end

  def new
    @guess = Guess.new
  end

  def create
    @guess = Guess.new(guess_params)

    if @guess.save
      redirect_to @guess, notice: 'Guess was successfully created. Thanks for playing!'
    else
      puts 'There was an error!'
      render :new
    end
  end

  private

    def guess_params
      params.require(:guess).permit(:quantity, :player_id, :jar_id)
    end

end
