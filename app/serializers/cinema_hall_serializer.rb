# frozen_string_literal: true

class CinemaHallSerializer
  include JSONAPI::Serializer
  attributes :name, :row_number, :row_total_seats
  has_many :screenings
end
