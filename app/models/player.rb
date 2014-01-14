class Player < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name,
    scope: :group_id,
    message: 'A player with this name has already been created.'

  validates_presence_of :group
  belongs_to :group

  has_many :guesses
  has_many :jars,
    through: :guesses

end
