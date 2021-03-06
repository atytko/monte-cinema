# frozen_string_literal: true

module Reservations
  module UseCases
    class FetchAll
      def initialize(repository: Reservations::Repository.new)
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
