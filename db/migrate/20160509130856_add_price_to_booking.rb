class AddPriceToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :price, :decimal, precision: 8, scale: 2
  end
end
