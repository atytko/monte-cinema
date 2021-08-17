# frozen_string_literal: true

class UserRole < ApplicationRecord
  has_many :users, dependent: :destroy
  def self.default
    find_by(name: 'client')
  end
end
