class Flight < ActiveRecord::Base
  belongs_to :departure_location, class_name: "Airport"
  belongs_to :arrival_location, class_name: "Airport"
  has_many :bookings
  has_many :passengers

  scope :location, (lambda do |loc|
    where("departure_location_id = ?", loc)
  end)

  scope :destination, (lambda do |dest|
    where("arrival_location_id = ?", dest)
  end)

  scope :when, (lambda do |ddate|
    where("departure_date > ?", (Date.parse(ddate) - 1).to_time).
      where("departure_date < ?", (Date.parse(ddate) + 1).to_time)
  end)

  validates :departure_location_id, :arrival_location_id, :flight_number,
            :airline, :departure_date, :arrival_date,
            presence: true

  def self.filter(filtering_params)
    results = where(nil)
    filtering_params.each do |key, value|
      results = results.public_send(key, value) if value.present?
    end
    results
  end
end
