# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_cinema_halls'

RSpec.describe CinemaHallsController, type: :request do
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }

  describe '#index' do
    subject(:get_cinema_halls) { get '/cinema_halls' }

    let(:cinema_hall) { create(:cinema_hall) }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 200 http status' do
        get_cinema_halls
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#show' do
    subject(:get_cinema_hall) { get "/cinema_halls/#{cinema_hall.id}" }

    let(:cinema_hall) { create(:cinema_hall) }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 200 http status' do
        get_cinema_hall
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#create' do
    subject(:create_cinema_hall) do
      post '/cinema_halls', params: { cinema_hall: { name: 'hall_1', row_number: 10, row_total_seats: 20 } }
    end

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 201 http status' do
        create_cinema_hall
        expect(response).to have_http_status(:created)
      end

      it 'works and the count is changed properly' do
        expect { create_cinema_hall }.to change(CinemaHall, :count).by(1)
      end

      it 'does not allow to create cinema hall with missing params' do
        expect { post '/cinema_halls', params: {} }
          .to raise_error(ActionController::ParameterMissing)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#update' do
    subject(:update_cinema_hall) do
      patch "/cinema_halls/#{cinema_hall.id}",
            params: { cinema_hall: { name: 'hall_2', row_number: 5, row_total_seats: 10 } }
    end

    let(:cinema_hall) { create(:cinema_hall) }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 200 http status' do
        update_cinema_hall
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#destroy' do
    subject(:delete_cinema_hall) { delete "/cinema_halls/#{cinema_hall.id}" }

    let!(:cinema_hall) { create(:cinema_hall) }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 204 http status' do
        delete_cinema_hall
        expect(response).to have_http_status(:no_content)
      end

      it 'works and the count is changed properly' do
        expect { delete_cinema_hall }.to change(CinemaHall, :count).by(-1)
      end
    end

    include_examples 'unauthorized'
  end
end
