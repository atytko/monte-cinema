# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_cinema_hall, only: %i[show update destroy]

  def index
    cinema_halls = CinemaHall.all

    render json: cinema_halls
  end

  def show
    render json: @cinema_hall
  end

  def create
    cinema_hall = CinemaHall.new(cinema_hall_params)
    if cinema_hall.save
      render json: cinema_hall, status: :created, location: cinema_hall
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def update
    if @cinema_hall.update(cinema_hall_params)
      render json: @cinema_hall
    else
      render json: @cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cinema_hall.destroy
    head :no_content
  end

  private

  def find_cinema_hall
    @cinema_hall = CinemaHall.find(params[:id])
  end

  def cinema_hall_params
    params.require(:cinema_hall).permit(:name, :row_number, :row_total_seats)
  end
end
