class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :booking_id
      t.decimal :price, precision: 8, scale: 2
      t.integer :flight_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
