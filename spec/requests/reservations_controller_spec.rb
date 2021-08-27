# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_controllers'

RSpec.describe ReservationsController, type: :request do
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }

  describe '#index' do
    subject(:get_reservations) { get '/reservations' }

    let(:reservation) { create(:reservation) }

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 200 http status' do
        get_reservations
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#show' do
    subject(:get_reservation) { get "/reservations/#{reservation.id}" }

    let(:reservation) { create(:reservation) }

    context 'when the user is logged in employee' do
      let(:role) { create(:user_role, name: 'employee') }

      sign_in :user

      it 'returns 200 http status' do
        get_reservation
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is logged in client - owner of the reservation' do
      let(:reservation) { create(:reservation, user: user) }

      sign_in :user

      it 'returns 200 http status' do
        get_reservation
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#update' do
    subject(:update_reservation) do
      patch "/reservations/#{reservation.id}",
            params: { reservation: { status: 'pending' } }
    end

    let(:reservation) { create(:reservation) }

    context 'when the user is logged in as employee' do
      let(:role) { create(:user_role, name: 'employee') }

      sign_in :user

      it 'returns 200 http status' do
        update_reservation
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is logged in as client (owner of the reservation)' do
      let(:reservation) { create(:reservation, user: user) }

      sign_in :user

      it 'returns 200 http status' do
        update_reservation
        expect(response).to have_http_status(:ok)
      end
    end

    include_examples 'unauthorized'
  end
end
