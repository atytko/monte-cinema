# frozen_string_literal: true

class ScreeningSerializer
  include JSONAPI::Serializer
  attributes :screening_time
  belongs_to :movie
  belongs_to :cinema_hall
end
