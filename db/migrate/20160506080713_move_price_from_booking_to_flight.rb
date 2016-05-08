class MovePriceFromBookingToFlight < ActiveRecord::Migration
  def change
    remove_column :bookings, :price, :decimal
    add_column :flights, :price, :decimal, precision: 8, scale: 2
  end
end
