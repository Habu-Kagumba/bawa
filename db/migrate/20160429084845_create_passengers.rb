class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :booking_id
      t.integer :flight_id

      t.timestamps null: false
    end

    add_index :passengers, :booking_id
    add_index :passengers, :flight_id
  end
end
