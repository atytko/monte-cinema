# frozen_string_literal: true

module Reservations
  class Repository
    attr_reader :adapter

    def initialize(adapter: Reservation)
      @adapter = adapter
    end

    def all
      adapter.all
    end

    def find(id)
      adapter.find(id)
    end

    def create(params)
      adapter.create(params)
    end

    def update(id, params)
      reservation = adapter.find(id)
      reservation.update(params)
      reservation
    end
  end
end
