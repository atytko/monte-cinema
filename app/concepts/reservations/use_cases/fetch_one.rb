# frozen_string_literal: true

module Reservations
  module UseCases
    class FetchOne
      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(id:)
        repository.find(id)
      end

      private

      attr_reader :repository
    end
  end
end
