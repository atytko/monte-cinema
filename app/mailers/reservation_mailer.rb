# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  def confirm_reservation(email, reservation)
    @email = email
    @reservation = reservation
    @tickets = Ticket.joins(:ticket_type).where(reservation_id: reservation.id)
    @seats = SeatsReservation.where(reservation_id: reservation.id)

    mail(to: @email, subject: 'Monte Cinema - your reservation has been confirmed')
  end

  def cancel_reservation(email, reservation)
    @email = email
    @reservation = reservation

    mail(to: @email, subject: 'Monte Cinema - your reservation has been cancelled')
  end
end
