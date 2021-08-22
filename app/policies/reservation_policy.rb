# frozen_string_literal: true

class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :reservation

  def initialize(user, _movie)
    @user = user
    @reservation = reservation
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
end
