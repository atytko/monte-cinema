# frozen_string_literal: true

class ReservationSerializer
  include JSONAPI::Serializer
  attributes :status
  belongs_to :screening
  belongs_to :ticket_desk
  belongs_to :user
  has_many :seats_reservations
  has_many :tickets
end
