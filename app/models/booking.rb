class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :flight
  has_many :passengers
  accepts_nested_attributes_for :passengers, reject_if: :all_blank,
    allow_destroy: true

  before_save do
    self.booking_id = Faker::Code.flight
  end

  validates :flight_id,
            presence: true
end
