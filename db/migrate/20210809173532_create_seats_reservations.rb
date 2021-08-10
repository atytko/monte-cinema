# frozen_string_literal: true

class CreateSeatsReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :seats_reservations do |t|
      t.string :row, null: false
      t.integer :seat_number, null: false
      t.references :reservation, null: false
      t.references :cinema_hall, null: false

      t.timestamps
    end
  end
end
