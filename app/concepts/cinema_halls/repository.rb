# frozen_string_literal: true

module CinemaHalls
  class Repository
    attr_reader :adapter

    def initialize(adapter: CinemaHall)
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
      cinema_hall = adapter.find(id)
      cinema_hall.update(params)
      cinema_hall
    end

    def delete(id)
      adapter.find(id).delete
    end
  end
end
