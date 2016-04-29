class Flight < ActiveRecord::Base
  belongs_to :departure_location, class_name: "Airport"
  belongs_to :arrival_location, class_name: "Airport"

  scope :location, -> (loc_id) { where departure_location_id: loc_id }

  scope :destination, -> (loc_id) { where arrival_location_id: loc_id }

  scope :when, lambda do |ddate|
    where("departure_date > ?", Date.parse(ddate).to_time).
      where("departure_date < ?", (Date.parse(ddate) + 1).to_time)
  end

  validates :departure_location_id, :arrival_location_id, :flight_number,
            :airline, :departure_date, :arrival_date,
            presence: true

  def departure_time
    departure_date.strftime("%H:%M")
  end

  def arrival_time
    arrival_date.strftime("%H:%M")
  end

  class << self
    def filter(filtering_params)
      results = where(nil)
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
