# frozen_string_literal: true

class MoviesController < ApplicationController
  include JSONAPI::Fetching
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    movies = Movie.all

    render jsonapi: movies, except: blacklisted_attributes
  end

  def show
    movie = Movie.find(params[:id])

    render jsonapi: movie, except: blacklisted_attributes
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render jsonapi: movie, status: :created, location: movie
    else
      render jsonapi: movie.errors, status: :unprocessable_entity
    end
  end

  def update
    movie = Movie.find(params[:id])
    if movie.update(movie_params)
      render jsonapi: movie
    else
      render jsonapi: movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
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
