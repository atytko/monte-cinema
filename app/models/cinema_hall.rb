# frozen_string_literal: true

class CinemaHall < ApplicationRecord
  has_many :screenings, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :row_number, presence: true, inclusion: { in: 5..10 }
  validates :row_total_seats, presence: true, inclusion: { in: 4..20 }
end
