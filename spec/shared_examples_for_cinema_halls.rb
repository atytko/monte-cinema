# frozen_string_literal: true

RSpec.shared_examples 'unauthorized' do |_parameter|
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }

  context 'when the user is not logged in' do
    it 'returns 401 http status' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
