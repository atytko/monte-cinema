# frozen_string_literal: true

class MoviePolicy < ApplicationPolicy
  attr_reader :user, :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  def create?
    user.manager? || user.employee?
  end

  def update?
    user.manager? || user.employee?
  end

  def destroy?
    user.manager? || user.employee?
  end
end
