class Group < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :user

  belongs_to :user

end
