# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  include JSONAPI::Fetching

  def index
    authorize CinemaHall
    cinema_halls = CinemaHall.all

    render jsonapi: cinema_halls, except: blacklisted_attributes
  end

  def show
    cinema_hall = CinemaHall.find(params[:id])
    authorize cinema_hall

    render jsonapi: cinema_hall, except: blacklisted_attributes
  end

  def create
    cinema_hall = CinemaHall.new(cinema_hall_params)
    authorize cinema_hall
    if cinema_hall.save
      render jsonapi: cinema_hall, status: :created, location: cinema_hall
    else
      render jsonapi: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def update
    cinema_hall = CinemaHall.find(params[:id])
    authorize cinema_hall
    if cinema_hall.update(cinema_hall_params)
      render jsonapi: cinema_hall
    else
      render jsonapi: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def destroy
    cinema_hall = CinemaHall.find(params[:id])
    authorize cinema_hall
    cinema_hall.destroy
    head :no_content
  end

  private

  def cinema_hall_params
    params.require(:cinema_hall).permit(:name, :row_number, :row_total_seats)
  end

  def blacklisted_attributes
    %w[created_at updated_at]
  end
end
