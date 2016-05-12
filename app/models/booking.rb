class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :flight
  has_many :passengers

  extend FriendlyId
  friendly_id :booking_id, use: [:slugged, :finders]

  accepts_nested_attributes_for :passengers, reject_if: :all_blank,
                                             allow_destroy: true

  before_save do
    self.booking_id = Faker::Code.flight
  end

  validates :flight_id,
            presence: true

  private

  def should_generate_new_friendly_id?
    slug.blank? || booking_id_changed?
  end
end
