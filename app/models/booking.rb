class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :flight
  has_many :passengers

  before_save do
    self.booking_id = Faker::Code.flight
  end

  validates :flight_id,
            presence: true
end
