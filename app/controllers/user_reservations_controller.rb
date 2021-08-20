# frozen_string_literal: true

class UserReservationsController < ApplicationController
  include JSONAPI::Fetching

  def index
    reservations = current_user.reservations

    render jsonapi: reservations, except: blacklisted_attributes
  end

  private

  def blacklisted_attributes
    %w[created_at updated_at]
  end
end
