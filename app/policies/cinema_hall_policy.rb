# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
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
