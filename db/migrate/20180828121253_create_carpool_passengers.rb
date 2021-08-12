class CreateCarpoolPassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :carpool_passengers do |t|
      t.integer :user_id
      t.integer :carpool_id
      t.integer :initial_pickup_location_id
      t.integer :final_pickup_location_id

      t.timestamps
    end

    add_index :carpool_passengers, :user_id
    add_index :carpool_passengers, :carpool_id
    add_index :carpool_passengers, :initial_pickup_location_id
    add_index :carpool_passengers, :final_pickup_location_id
  end
end
