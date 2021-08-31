# frozen_string_literal: true

class TicketType < ApplicationRecord
  has_many :tickets, dependent: :destroy
  validates :price, presence: true
  validates :name, presence: true
end
