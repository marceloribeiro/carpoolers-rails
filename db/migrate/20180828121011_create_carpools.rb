# frozen_string_literal: true

class CreateCarpools < ActiveRecord::Migration[5.2]
  def change
    create_table :carpools do |t|
      t.integer :user_id
      t.integer :chapter_id
      t.integer :seats_available
      t.integer :frequency
      t.integer :weekday
      t.integer :monthday
      t.date    :carpool_date
      t.time    :starts_at
      t.integer :start_pickup_location_id
      t.integer :end_pickup_location_id
      t.timestamps
    end

    add_index :carpools, :user_id
    add_index :carpools, :chapter_id
  end
end
