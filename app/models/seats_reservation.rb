# frozen_string_literal: true

class SeatsReservation < ApplicationRecord
  belongs_to :reservation
  belongs_to :cinema_hall
  validates :row, presence: true
  validates :seat_number, presence: true

  before_validation :set_cinema_hall, on: :create

  private

  def set_cinema_hall
    self.cinema_hall = reservation.screening.cinema_hall
  end
end
