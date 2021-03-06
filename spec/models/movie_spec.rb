# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#validations' do
    subject { build(:movie) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:genre) }
    it { is_expected.to validate_presence_of(:director) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_numericality_of(:duration).is_greater_than(10) }
  end

  describe '#associations' do
    it { is_expected.to have_many(:screenings) }
  end
end
