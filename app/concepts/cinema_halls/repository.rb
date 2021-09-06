# frozen_string_literal: true

module CinemaHalls
  class Repository < ::BaseRepository
    def initialize(adapter: CinemaHall)
      super(adapter: adapter)
    end
  end
end
