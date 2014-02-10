class Jar < ActiveRecord::Base

  validates_presence_of :contents
  validates_uniqueness_of :contents,
    scope: :game_id,
    message: 'A jar with these contents has already been created.'

  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  validates_presence_of :game
  belongs_to :game

  has_many :guesses
  has_many :players,
    through: :guesses

  def calculate_winner
    if self.guesses.present?
      eligible_guesses = self.guesses.select{ |g| g.quantity <= self.quantity }
      if eligible_guesses.empty?
        nil
      else
        winning_guess = eligible_guesses.max_by{ |g| g.quantity }
        winning_guess.player
      end
    end
  end

end
