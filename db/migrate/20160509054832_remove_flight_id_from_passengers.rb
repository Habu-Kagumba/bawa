class RemoveFlightIdFromPassengers < ActiveRecord::Migration
  def change
    remove_column :passengers, :flight_id, :integer
  end
end
