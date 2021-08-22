# frozen_string_literal: true

class SeatsReservation < ApplicationRecord
  belongs_to :reservation
  belongs_to :cinema_hall
  validate :validates_seat_reservation

  before_validation :set_cinema_hall, on: :create

  def seat_is_taken?
    SeatsReservation
      .joins(:reservation)
      .where(
        row: row,
        seat_number: seat_number,
        reservations: { screening: reservation.screening }
      )
      .any?
  end

  private

  def validates_seat_reservation
    errors.add(:seat_reservation, 'this seat is already taken') if seat_is_taken?
  end

  def set_cinema_hall
    self.cinema_hall = reservation.screening.cinema_hall
  end
end
