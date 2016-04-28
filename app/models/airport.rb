class Airport < ActiveRecord::Base
  has_many :flights

  validates :name, presence: true
  validates :location, presence: true
end
