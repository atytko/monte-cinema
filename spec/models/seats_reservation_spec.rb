# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SeatsReservation, type: :model do
  describe '"validations"' do
    let(:reservation) { create(:reservation, screening: screening) }
    let(:screening) { create(:screening, movie: movie, cinema_hall: cinema_hall) }
    let(:movie) { create(:movie) }
    let(:cinema_hall) { create(:cinema_hall) }

    before do
      create(:seats_reservation, reservation: reservation, cinema_hall: cinema_hall, row: 'A', seat_number: 6)
    end

    it 'allows to create reservation when seat is not yet reserved' do
      seat_reservation = described_class.create(reservation: reservation,
                                                cinema_hall: cinema_hall, row: 'A', seat_number: 12)
      expect(seat_reservation.errors[:seat_reservation]).not_to include('this seat is already taken')
    end

    it 'throws an error when trying to book a seat already reserved' do
      seat_reservation = described_class.create(reservation: reservation,
                                                cinema_hall: cinema_hall, row: 'A', seat_number: 6)
      expect(seat_reservation.errors[:seat_reservation]).to include('this seat is already taken')
    end
  end
end
