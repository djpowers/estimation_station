class Player < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name,
    scope: :game_id,
    message: 'A player with this name has already been created.'

  validates_presence_of :game
  belongs_to :game

  has_many :guesses
  has_many :jars,
    through: :guesses

end
