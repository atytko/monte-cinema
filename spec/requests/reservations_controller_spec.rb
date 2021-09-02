# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_controllers'

RSpec.describe ReservationsController, type: :request do
  let(:role) { create(:user_role) }
  let(:user) { create(:user, user_role: role) }
  let(:screening) { create(:screening, movie: movie, cinema_hall: cinema_hall) }
  let(:movie) { create(:movie) }
  let(:cinema_hall) { create(:cinema_hall) }
  let(:ticket_type) { create(:ticket_type) }
  let(:ticket_desk) { create(:ticket_desk) }

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

  describe '#create' do
    subject(:create_reservation) do
      post '/reservations/online',
           params: {
             screening_id: screening.id,
             tickets_attributes: [
               { ticket_type_id: ticket_type.id },
               { ticket_type_id: ticket_type.id }
             ],
             seats_reservations_attributes: [{ row: 'B', seat_number: 12 }, { row: 'D', seat_number: 5 }]
           }
    end

    context 'when the user is logged in' do
      sign_in :user

      it 'returns 201 http status' do
        create_reservation
        expect(response).to have_http_status(:created)
      end

      it 'works and the count is changed properly' do
        expect { create_reservation }.to change(Reservation, :count).by(1)
      end
    end

    include_examples 'unauthorized'
  end

  describe '#create_offline' do
    subject(:create_offline_reservation) do
      post '/reservations/offline',
           params: {
             screening_id: screening.id,
             ticket_desk_id: ticket_desk.id,
             user_id: user.id,
             tickets_attributes: [
               { ticket_type_id: ticket_type.id },
               { ticket_type_id: ticket_type.id }
             ],
             seats_reservations_attributes: [{ row: 'H', seat_number: 12 }, { row: 'H', seat_number: 13 }]
           }
    end

    context 'when the user is logged in' do
      let(:role) { create(:user_role, name: 'employee') }

      sign_in :user

      it 'returns 201 http status' do
        create_offline_reservation
        expect(response).to have_http_status(:created)
      end

      it 'works and the count is changed properly' do
        expect { create_offline_reservation }.to change(Reservation, :count).by(1)
      end
    end

    context 'when the user is not employee or manager' do
      sign_in :user

      it 'returns 403 http status' do
        create_offline_reservation
        expect(response).to have_http_status(:forbidden)
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
