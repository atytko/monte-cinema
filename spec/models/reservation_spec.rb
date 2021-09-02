# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#validations' do
    subject { build(:reservation) }

    it { is_expected.to validate_presence_of(:status) }
  end

  describe '#associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to belong_to(:ticket_desk).optional }
    it { is_expected.to belong_to(:screening) }
    it { is_expected.to have_many(:tickets) }
    it { is_expected.to have_many(:seats_reservations) }
    it { is_expected.to accept_nested_attributes_for(:tickets) }
    it { is_expected.to accept_nested_attributes_for(:seats_reservations) }
  end
end
