class Flight < ActiveRecord::Base
  belongs_to :departure_location, class_name: 'Airport'
  belongs_to :arrival_location, class_name: 'Airport'
  has_many :bookings
  has_many :passengers

  scope :location, -> (departure_location_id) {
    where departure_location_id: departure_location_id
  }

  scope :destination, -> (arrival_location_id) {
    where arrival_location_id: arrival_location_id
  }

  scope :when, -> (departure_date) {
    where("departure_date > ?", Date.parse(departure_date).to_time)
      .where("departure_date < ?", (Date.parse(departure_date) + 1).to_time)
  }

  validates :departure_location_id, :arrival_location_id, :flight_number,
            :airline, :departure_date, :arrival_date,
            presence: true

  def departure_time
    self.departure_date.strftime("%H:%M")
  end

  def arrival_time
    self.arrival_date.strftime("%H:%M")
  end

  class << self
    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
