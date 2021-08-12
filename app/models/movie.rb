# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :screenings, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :genre, presence: true
  validates :director, presence: true
  validates :duration, presence: true, numericality: { greater_than: 10 }
end
