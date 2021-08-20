# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SeatValidator do
  describe '.seat_is_taken?' do
    subject { described_class.seat_is_taken?(row, seat_number, screening) }

    let!(:seats_reservation) { create(:seats_reservation, reservation: reservation, cinema_hall: cinema_hall) }
    let(:reservation) { create(:reservation, screening: screening) }
    let(:screening) { create(:screening, movie: movie, cinema_hall: cinema_hall) }
    let(:movie) { create(:movie) }
    let(:cinema_hall) { create(:cinema_hall) }
    let(:row) { 'A' }
    let(:seat_number) { 6 }

    context 'when seat reservation does not exist for this screening' do
      let!(:seats_reservation) do
        create(:seats_reservation, reservation: reservation,
                                   cinema_hall: cinema_hall, row: row, seat_number: reservation_seat_number)
      end
      let(:reservation_seat_number) { 12 }

      it { is_expected.to eq(false) }
    end

    context 'when seat reservation already exists for this screening' do
      let!(:seats_reservation) do
        create(:seats_reservation, reservation: reservation,
                                   cinema_hall: cinema_hall, row: row, seat_number: seat_number)
      end

      it { is_expected.to eq(true) }
    end

    it {}
  end
end
