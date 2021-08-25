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
    admin_or_owner?
  end

  def create?
    true
  end

  def update?
    admin_or_owner?
  end

  private

  def admin_or_owner?
    if user.employee? || user.manager?
      true
    else
      user.id == record.user_id
    end
  end
end
