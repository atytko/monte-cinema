# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :screening, null: false
      t.references :user, null: false
      t.references :ticket_desk
      t.references :reservation_status, null: false

      t.timestamps
    end
  end
end
