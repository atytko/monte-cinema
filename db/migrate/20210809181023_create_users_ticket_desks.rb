# frozen_string_literal: true

class CreateUsersTicketDesks < ActiveRecord::Migration[6.1]
  def change
    create_table :users_ticket_desks do |t|
      t.references :user, null: false
      t.references :ticket_desk, null: false

      t.timestamps
    end
  end
end
