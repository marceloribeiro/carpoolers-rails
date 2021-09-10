# frozen_string_literal: true

class CreateCarpoolPassengers < ActiveRecord::Migration[5.2]
  def change
    create_table :carpool_passengers do |t|
      t.integer :user_id
      t.integer :carpool_id
      t.integer :pickup_location_id
      t.integer :dropoff_location_id
      t.integer :status
      t.timestamps
    end

    add_index :carpool_passengers, :user_id
    add_index :carpool_passengers, :carpool_id
    add_index :carpool_passengers, :pickup_location_id
    add_index :carpool_passengers, :dropoff_location_id
  end
end
