class AddBookingSlug < ActiveRecord::Migration
  def change
    add_column :bookings, :slug, :string
    add_index :bookings, :slug, unique: true
  end
end
