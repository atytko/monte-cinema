# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Sample movie #{n}" }
    description { 'Lorem ipsum dolor sit amet' }
    genre { 'Sample genre' }
    director { 'Sample director' }
    duration { 90 }
  end
end
