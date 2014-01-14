class Jar < ActiveRecord::Base

  validates_presence_of :contents
  validates_uniqueness_of :contents

  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  validates_presence_of :group
  belongs_to :group

  has_many :guesses
  has_many :players,
    through: :guesses

  def calculate_winner
    eligible_guesses = self.guesses.select{ |g| g.quantity <= self.quantity }
    winning_guess = eligible_guesses.max_by{ |g| g.quantity }
    winning_guess.player
  end

end
