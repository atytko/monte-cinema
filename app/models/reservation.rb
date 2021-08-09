# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :reservation_status
  belongs_to :ticket_desk, optional: true
  belongs_to :screening
  has_many :seats, dependent: :destroy
  has_many :tickets, dependent: :destroy
end
