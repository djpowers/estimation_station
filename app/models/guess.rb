class Guess < ActiveRecord::Base

  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  validates_presence_of :player
  belongs_to :player

  validates_presence_of :jar
  belongs_to :jar

end
