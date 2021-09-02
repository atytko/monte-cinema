# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketType, type: :model do
  describe '#validations' do
    subject { build(:ticket_type) }

    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#associations' do
    it { is_expected.to have_many(:tickets) }
  end
end
