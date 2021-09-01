# frozen_string_literal: true

class CinemaHallPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    super
    @user = user
    @record = record
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
