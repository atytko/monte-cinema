# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_controllers'

RSpec.describe CinemaHallsController, type: :request do
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }

  describe '#index' do
    subject(:get_cinema_halls) { get '/cinema_halls' }

    let(:cinema_hall) { create(:cinema_hall) }

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }

      sign_in :user

      it 'returns 200 http status' do
        get_cinema_halls
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'

    context 'when user is not employee or manager' do
      sign_in :user

      it 'returns 403 http status' do
        get_cinema_halls
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '#show' do
    subject(:get_cinema_hall) { get "/cinema_halls/#{cinema_hall.id}" }

    let(:cinema_hall) { create(:cinema_hall) }
    let(:expected_response) do
      {
        'data' => {
          'id' => cinema_hall.id.to_s,
          'type' => 'cinema_hall',
          'attributes' => {
            'name' => cinema_hall.name,
            'row_number' => cinema_hall.row_number,
            'row_total_seats' => cinema_hall.row_total_seats
          },
          'relationships' => {
            'screenings' => {
              'data' => []
            }
          }
        }
      }
    end

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }

      sign_in :user

      it 'returns 200 http status' do
        get_cinema_hall
        expect(response).to have_http_status(:ok)
      end

      it 'works and returns a valid response' do
        get_cinema_hall
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#create' do
    subject(:create_cinema_hall) do
      post '/cinema_halls', params: { cinema_hall: { name: 'hall_1', row_number: 10, row_total_seats: 20 } }
    end

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }

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

    context 'when user is not employee or manager' do
      sign_in :user

      it 'returns 403 http status' do
        create_cinema_hall
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '#update' do
    subject(:update_cinema_hall) do
      patch "/cinema_halls/#{cinema_hall.id}",
            params: { cinema_hall: { name: 'hall_2', row_number: 5, row_total_seats: 10 } }
    end

    let(:cinema_hall) { create(:cinema_hall) }

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }

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
      let(:role) { create(:user_role, name: 'employee') }

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
