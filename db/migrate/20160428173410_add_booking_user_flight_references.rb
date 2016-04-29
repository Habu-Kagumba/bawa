class AddBookingUserFlightReferences < ActiveRecord::Migration
  def change
    add_index :bookings, :user_id
    add_index :bookings, :flight_id
  end
end
