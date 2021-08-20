# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    status { 'pending' }
    screening
  end
end
