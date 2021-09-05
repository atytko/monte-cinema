# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class FetchAll
      def initialize(repository: CinemaHalls::Repository.new)
        @repository = repository
      end

      def call
        repository.all
      end

      private

      attr_reader :repository
    end
  end
end
