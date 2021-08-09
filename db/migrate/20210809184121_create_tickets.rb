# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.references :reservation, null: false
      t.references :ticket_type, null: false

      t.timestamps
    end
  end
end
