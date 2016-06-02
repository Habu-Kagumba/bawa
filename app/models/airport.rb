class Airport < ActiveRecord::Base
  has_many :flights

  validates :name, :location, presence: true

  def self.search(datum)
    where("location ILIKE ? OR name ILIKE ?", "%#{datum}%", "%#{datum}%")
  end
end
