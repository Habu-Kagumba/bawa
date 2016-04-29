class AddAirportToFlight < ActiveRecord::Migration
  def change
    add_index :flights, :departure_location_id
    add_index :flights, :arrival_location_id
  end
end
