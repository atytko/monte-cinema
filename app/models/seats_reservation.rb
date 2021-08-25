# frozen_string_literal: true

class SeatsReservation < ApplicationRecord
  belongs_to :reservation
  belongs_to :cinema_hall

  before_validation :set_cinema_hall, on: :create

  private

  def set_cinema_hall
    self.cinema_hall = reservation.screening.cinema_hall
  end
end
