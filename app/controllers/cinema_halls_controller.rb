# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :authenticate_user!

  def index
    cinema_halls = CinemaHall.all

    render json: cinema_halls
  end
end
