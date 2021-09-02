# frozen_string_literal: true

module CinemaHalls
  module UseCases
    class Create
      def initialize(repository: CinemaHalls::Repository.new)
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
