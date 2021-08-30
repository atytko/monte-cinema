# frozen_string_literal: true

class ReservationsController < ApplicationController
  include JSONAPI::Fetching

  def index
    reservations = policy_scope(Reservation).where(screening: params[:screening_id])

    render jsonapi: reservations, except: blacklisted_attributes
  end

  def show
    reservation = Reservation.find(params[:id])
    authorize reservation

    render jsonapi: reservation, except: blacklisted_attributes
  end

  def create
    authorize Reservation
    if already_booked?
      render json: { error: 'One or more seats is taken' }, status: :unprocessable_entity
    else
      reservation = current_user.reservations.new(reservation_params)
      if reservation.save
        render jsonapi: reservation, status: :created
        ReservationMailer.confirm_reservation(current_user.email, reservation).deliver_now
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    end
  end

  def create_offline
    authorize Reservation
    if already_booked?
      render json: { error: 'One or more seats is taken' }, status: :unprocessable_entity
    else
      reservation = Reservation.new(offline_reservation_params)
      if reservation.save
        render jsonapi: reservation, status: :created
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    reservation = Reservation.find(params[:id])
    authorize reservation
    if reservation.update(update_reservation_params)
      render jsonapi: reservation
    else
      render jsonapi: reservation.errors, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.permit(:screening_id, tickets_attributes: [:ticket_type_id],
                                 seats_reservations_attributes: %i[row seat_number])
  end

  def offline_reservation_params
    params.permit(:screening_id, :ticket_desk_id, :user_id, tickets_attributes: [:ticket_type_id],
                                                            seats_reservations_attributes: %i[row seat_number])
  end

  def update_reservation_params
    params.permit(:status)
  end

  def blacklisted_attributes
    %w[created_at updated_at]
  end

  def already_booked?
    reservation_params[:seats_reservations_attributes].any? do |seat|
      SeatValidator.seat_is_taken?(seat[:row], seat[:seat_number], reservation_params[:screening_id])
    end
  end
end
