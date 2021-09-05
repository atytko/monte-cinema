# frozen_string_literal: true

class MoviesController < ApplicationController
  include JSONAPI::Fetching
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    render jsonapi: Movies::UseCases::FetchAll.new.call, except: blacklisted_attributes
  end

  def show
    render jsonapi: Movies::UseCases::FetchOne.new.call(id: params[:id]), except: blacklisted_attributes
  end

  def create
    authorize Movie
    movie = Movies::UseCases::Create.new.call(params: movie_params)
    if movie.valid?
      render jsonapi: movie, status: :created
    else
      render jsonapi: movie.errors, status: :unprocessable_entity
    end
  end

  def update
    movie = Movies::UseCases::FetchOne.new.call(id: params[:id])
    authorize movie
    updated_movie = Movies::UseCases::Update.new.call(id: params[:id], params: movie_params)
    if updated_movie.valid?
      render jsonapi: updated_movie
    else
      render jsonapi: updated_movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Movie
    Movies::UseCases::Delete.new.call(id: params[:id])
    head :no_content
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :duration, :description, :genre, :director)
  end

  def blacklisted_attributes
    %w[created_at updated_at]
  end
end
