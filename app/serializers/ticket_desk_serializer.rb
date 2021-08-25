# frozen_string_literal: true

class TicketDeskSerializer
  include JSONAPI::Serializer
  attributes :status
  has_many :users_ticket_desks
  has_many :reservations
  has_many :users
end
