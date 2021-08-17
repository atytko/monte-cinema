# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  include JSONAPI::Fetching

  def index
    cinema_halls = CinemaHall.all

    render jsonapi: cinema_halls
  end

  def show
    cinema_hall = CinemaHall.find(params[:id])

    render jsonapi: cinema_hall, only: whitelisted_attributes
  end

  def create
    cinema_hall = CinemaHall.new(cinema_hall_params)
    if cinema_hall.save
      render jsonapi: cinema_hall, status: :created, location: cinema_hall
    else
      render jsonapi: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def update
    cinema_hall = CinemaHall.find(params[:id])
    if cinema_hall.update(cinema_hall_params)
      render jsonapi: cinema_hall
    else
      render jsonapi: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def destroy
    cinema_hall = CinemaHall.find(params[:id])
    cinema_hall.destroy
    head :no_content
  end

  private

  def cinema_hall_params
    params.require(:cinema_hall).permit(:name, :row_number, :row_total_seats)
  end

  def whitelisted_attributes
    %w[name row_number row_total_seats]
  end
end
