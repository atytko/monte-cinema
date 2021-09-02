# frozen_string_literal: true

FactoryBot.define do
  factory :ticket_type do
    name { 'student' }
    price { 15 }
  end
end
