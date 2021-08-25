# frozen_string_literal: true

FactoryBot.define do
  factory :seats_reservation do
    row { 'A' }
    seat_number { 5 }
    reservation
    cinema_hall
  end
end
