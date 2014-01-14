class Group < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :user

  belongs_to :user
  has_many :players,
    dependent: :destroy,
    inverse_of: :group
  has_many :jars,
    dependent: :destroy,
    inverse_of: :group

  def calculate_winners
    winners = []
    self.jars.each do |jar|
      current_winner = ''
      current_best_guess = 0
      self.players.each do |player|
        if player.guesses.present?
          quantity = player.guesses.find_by(jar_id: jar.id).try(:quantity)
          if quantity > jar.quantity
            next
          else quantity > current_best_guess
            current_best_guess = quantity
            current_winner = player
          end
        end
      end
      winners << current_winner
    end
    winners
  end

end
