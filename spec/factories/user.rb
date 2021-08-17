# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    first_name { 'John' }
    last_name { 'Doe' }
    password { 'password' }
    password_confirmation { 'password' }
    user_role 
  end
end
