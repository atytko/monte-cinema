# frozen_string_literal: true

class SeatsReservation < ApplicationRecord
  belongs_to :reservation
  belongs_to :cinema_hall
end
