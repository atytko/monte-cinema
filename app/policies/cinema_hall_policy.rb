# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
  attr_reader :user, :cinema_hall

  def initialize(user, cinema_hall)
    @user = user
    @cinema_hall = cinema_hall
  end

  def index?
    user.manager? || user.employee?
  end

  def show?
    user.manager? || user.employee?
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
