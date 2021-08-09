# frozen_string_literal: true

class CreateReservationStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_statuses do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
