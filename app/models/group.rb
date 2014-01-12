class Group < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :user

  belongs_to :user
  has_many :players,
    inverse_of: :group
  has_many :jars,
    inverse_of: :group

  accepts_nested_attributes_for :players, :jars

end
