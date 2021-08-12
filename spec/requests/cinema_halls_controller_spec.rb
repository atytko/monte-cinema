# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHallsController, type: :request do
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }

  describe '#index' do
    subject { get '/cinema_halls' }

    context 'when the user is logged in' do
      sign_in :user

      it 'return valid http status' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
