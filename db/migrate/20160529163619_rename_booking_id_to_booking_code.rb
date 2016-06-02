class RenameBookingIdToBookingCode < ActiveRecord::Migration
  def change
    rename_column :bookings, :booking_id, :booking_code
  end
end
