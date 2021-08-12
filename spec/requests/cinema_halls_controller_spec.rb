# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHallsController, type: :request do
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }
  let!(:cinema_hall) { create(:cinema_hall) }

  describe '#index' do
    subject { get '/cinema_halls' }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns valid http status' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not logged in' do
      it 'returns 401 http status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#show' do
    subject { get "/cinema_halls/#{cinema_hall.id}" }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns success response' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not logged in' do
      it 'returns 401 http status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#create' do
    subject { post '/cinema_halls', params: { cinema_hall: { name: 'hall_1', row_number: 10, row_total_seats: 20 } } }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 201 http status' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'does not allow to create cinema hall with missing params' do
        expect { post '/cinema_halls', params: {} }
          .to raise_error(ActionController::ParameterMissing)
      end
    end

    context 'when the user is not logged in' do
      it 'returns 401 http status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#update' do
    subject do
      patch "/cinema_halls/#{cinema_hall.id}",
            params: { cinema_hall: { name: 'hall_2', row_number: 5, row_total_seats: 10 } }
    end

    context 'when the user is logged in' do
      sign_in :user

      it 'returns success response' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not logged in' do
      it 'returns 401 http status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#destroy' do
    subject { delete "/cinema_halls/#{cinema_hall.id}" }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 204 http status' do
        subject
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the user is not logged in' do
      it 'returns 401 http status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
