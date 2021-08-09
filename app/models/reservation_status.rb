# frozen_string_literal: true

class ReservationStatus < ApplicationRecord
  has_many :reservations, dependent: :destroy
end
