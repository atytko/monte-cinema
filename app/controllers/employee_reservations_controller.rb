# frozen_string_literal: true

class EmployeeReservationsController < ApplicationController
  include JSONAPI::Fetching

  def index
    authorize Reservation
    reservations = Reservation.where(screening: params[:screening_id])

    render jsonapi: reservations, except: blacklisted_attributes
  end

  def show
    reservation = Reservation.find(params[:id])
    authorize reservation

    render jsonapi: reservation, except: blacklisted_attributes
  end

  private

  def blacklisted_attributes
    %w[created_at updated_at]
  end
end
