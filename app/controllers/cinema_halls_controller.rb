# frozen_string_literal: true

class CinemaHallsController < ApplicationController
  include JSONAPI::Fetching

  def index
    authorize CinemaHall
    render jsonapi: CinemaHalls::UseCases::FetchAll.new.call, except: blacklisted_attributes
  end

  def show
    cinema_hall = CinemaHalls::UseCases::FetchOne.new.call(id: params[:id])
    authorize cinema_hall
    render jsonapi: cinema_hall, except: blacklisted_attributes
  end

  def create
    authorize CinemaHall
    cinema_hall = CinemaHalls::UseCases::Create.new.call(params: cinema_hall_params)
    if cinema_hall.valid?
      render jsonapi: cinema_hall, status: :created
    else
      render jsonapi: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize CinemaHall
    cinema_hall = CinemaHalls::UseCases::Update.new.call(id: params[:id], params: cinema_hall_params)
    if cinema_hall.valid?
      render jsonapi: cinema_hall
    else
      render jsonapi: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize CinemaHall
    CinemaHalls::UseCases::Delete.new.call(id: params[:id])
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
