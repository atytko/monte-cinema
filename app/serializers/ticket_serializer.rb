# frozen_string_literal: true

class TicketSerializer
  include JSONAPI::Serializer
  belongs_to :ticket_types
  belongs_to :reservation
end
