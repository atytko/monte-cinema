# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :cinema_hall
  validates :screening_time, presence: true
end
