# frozen_string_literal: true

FactoryBot.define do
  factory :cinema_hall do
    sequence(:name) { |n| "Sample cinema hall #{n}" }
    row_number { 10 }
    row_total_seats { 20 }
  end
end
