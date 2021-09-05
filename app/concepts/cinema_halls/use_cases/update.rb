# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Update
      def initialize(repository: CinemaHalls::Repository.new)
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
