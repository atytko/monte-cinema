# frozen_string_literal: true

module Reservations
  module UseCases
    class Update
      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(id:, params:)
        repository.update(id, params)
      end

      private

      attr_reader :repository
    end
  end
end
