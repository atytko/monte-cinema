# frozen_string_literal: true

class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :reservation

  def initialize(user, _movie)
    @user = user
    @reservation = reservation
  end

  def index?
    access?
  end

  def show?
    access?
  end

  def create?
    access?
  end

  def update?
    access?
  end

  private

  def access?
    user.manager? || user.employee?
  end
end
