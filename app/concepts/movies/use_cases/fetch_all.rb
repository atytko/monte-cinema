# frozen_string_literal: true

module Movies
  module UseCases
    class FetchAll
      def initialize(repository: Movies::Repository.new)
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
