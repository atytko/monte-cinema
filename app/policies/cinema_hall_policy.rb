# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
  attr_reader :user, :cinema_hall

  def initialize(user, cinema_hall)
    super
    @user = user
    @cinema_hall = cinema_hall
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

  def destroy?
    access?
  end

  private

  def access?
    user.manager? || user.employee?
  end
end
