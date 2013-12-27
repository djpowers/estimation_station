class Jar < ActiveRecord::Base

  validates_presence_of :contents
  validates_uniqueness_of :contents
  validates_uniqueness_of :contents

  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  validates_presence_of :player
  belongs_to :player

  has_many :guesses

end