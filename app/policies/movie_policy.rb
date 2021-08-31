# frozen_string_literal: true

class MoviePolicy < ApplicationPolicy
  attr_reader :user, :movie

  def initialize(user, movie)
    super
    @user = user
    @movie = movie
  end

  def create?
    access?
  end

  def update?
    access?
  end

  def destroy?
    access?
  end

  private

  def access?
    user.manager? || user.employee?
  end
end
