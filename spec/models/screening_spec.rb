# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Screening, type: :model do
  describe '#validations' do
    subject { build(:screening) }

    it { is_expected.to validate_presence_of(:screening_time) }
  end

  describe '#associations' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:cinema_hall) }
  end
end
