# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity.scoped_to(:provider) }
    it { is_expected.not_to allow_values('test@test', 'test.com', 'just_word').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe '#associations' do
    it { is_expected.to have_many(:reservations) }
    it { is_expected.to have_many(:users_ticket_desks) }
    it { is_expected.to belong_to(:user_role) }
  end

  context "when password confirmation doesn't match the password" do
    let(:user) { build(:user, password: '1234', password_confirmation: '123456') }

    it 'is not valid' do
      expect(user).not_to be_valid
      expect(user.errors.messages[:password_confirmation].first).to eq "doesn't match Password"
    end
  end
end
