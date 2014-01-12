class Player < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :group
  belongs_to :group

  has_many :guesses

end
