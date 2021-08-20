# frozen_string_literal: true

class SeatValidator
  def self.seat_is_taken?(row, seat_number, screening)
    SeatsReservation
      .joins(:reservation)
      .where(
        row: row,
        seat_number: seat_number,
        reservations: { screening: screening }
      )
      .any?
  end
end
