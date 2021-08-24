# frozen_string_literal: true

class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.manager? || user.employee?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def show?
    if user.employee? || user.manager?
      true
    else
      user.id == record.user_id
    end
  end

  def create?
    true
  end

  def update?
    true
  end
end
