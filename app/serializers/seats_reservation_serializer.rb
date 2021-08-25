# frozen_string_literal: true

class SeatsReservationSerializer
  include JSONAPI::Serializer
  attributes :row, :seat_number
  belongs_to :reservation
  belongs_to :cinema_hall
end
