class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.datetime :departure_date
      t.datetime :arrival_date
      t.integer :departure_location_id
      t.integer :arrival_location_id
      t.string :flight_number
      t.string :airline

      t.timestamps null: false
    end
  end
end
