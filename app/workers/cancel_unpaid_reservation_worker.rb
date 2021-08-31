# frozen_string_literal: true

class CancelUnpaidReservationWorker
  include Sidekiq::Worker

  def perform
    Reservation.where(status: 'pending')
               .where('screening_time < ?', Time.current + 30.minutes)
               .joins(:screening)
               .update_all(status: 'cancelled')

    ReservationMailer.cancel_reservation(User.find(id: reservation.user_id).email, reservation).deliver_now
  end
end
