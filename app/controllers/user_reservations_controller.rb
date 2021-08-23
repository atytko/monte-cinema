# frozen_string_literal: true

class UserReservationsController < ApplicationController
  include JSONAPI::Fetching

  def index
    reservations = current_user.reservations

    render jsonapi: reservations, except: blacklisted_attributes
  end

  def show
    reservation = current_user.reservations.find(params[:id])

    render jsonapi: reservation, except: blacklisted_attributes
  end

  def create
    if already_booked?
      render json: { error: 'One or more seats is taken' }, status: :unprocessable_entity
    else
      reservation = current_user.reservations.new(reservation_params)
      if reservation.save
        render jsonapi: reservation, status: :created
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    reservation = current_user.reservations.find(params[:id])
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
