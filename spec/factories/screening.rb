# frozen_string_literal: true

FactoryBot.define do
  factory :screening do
    movie
    cinema_hall
    screening_time { DateTime.current }
  end
end
