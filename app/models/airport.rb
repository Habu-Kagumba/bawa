class Airport < ActiveRecord::Base
  has_many :flights

  validates :name, presence: true
  validates :location, presence: true

  class << self
    def search(datum)
      where("location ILIKE ? OR name ILIKE ?", "%#{datum}%", "%#{datum}%")
    end
  end
end
