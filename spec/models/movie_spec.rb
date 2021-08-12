# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe '#validations' do
    subject { build(:movie) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:genre) }
    it { should validate_presence_of(:director) }
    it { should validate_presence_of(:duration) }
    it { should validate_numericality_of(:duration).is_greater_than(10) }
  end

  describe '#associations' do
    it { should have_many(:screenings) }
  end
end
