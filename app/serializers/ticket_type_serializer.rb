# frozen_string_literal: true

class TicketTypeSerializer
  include JSONAPI::Serializer
  attributes :name, :price
  has_many :tickets
end
