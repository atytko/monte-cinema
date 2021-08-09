# frozen_string_literal: true

class TicketDesk < ApplicationRecord
  has_many :users_ticket_desks, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :users, through: :users_ticket_desks
end
