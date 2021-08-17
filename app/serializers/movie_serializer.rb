# frozen_string_literal: true

class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :duration, :description, :genre, :director
  has_many :screenings
end
