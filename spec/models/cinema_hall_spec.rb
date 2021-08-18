# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHall, type: :model do
  describe '#validations' do
    subject { build(:cinema_hall) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:row_number) }
    it { is_expected.to validate_inclusion_of(:row_number).in_range(5..10) }
    it { is_expected.to validate_presence_of(:row_total_seats) }
    it { is_expected.to validate_inclusion_of(:row_total_seats).in_range(4..20) }
  end

  describe '#associations' do
    it { is_expected.to have_many(:screenings) }
  end
end
