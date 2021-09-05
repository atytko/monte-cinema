# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateOffline
      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(params:)
        repository.create(params)
      end

      private

      attr_reader :repository
    end
  end
end
