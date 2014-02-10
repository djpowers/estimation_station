class Game < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :user

  belongs_to :user
  has_many :players,
    dependent: :destroy,
    inverse_of: :game
  has_many :jars,
    dependent: :destroy,
    inverse_of: :game

  def display_winners
    winners = {}
    self.jars.each do |jar|
      if jar.nil?
        next
      elsif !jar.guesses.present?
        next
      else
        winners[jar.contents] = jar.calculate_winner.try(:name)
      end
    end
    winners
  end

end
