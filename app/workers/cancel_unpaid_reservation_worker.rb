# frozen_string_literal: true

class CancelUnpaidReservationWorker
  include Sidekiq::Worker

  def perform
    Reservation.where(status: 'pending')
               .where('screening_time < ?', DateTime.now + 30.minutes)
               .joins(:screening)
               .update_all(status: 'cancelled')
  end
end
