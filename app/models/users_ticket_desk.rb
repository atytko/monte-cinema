# frozen_string_literal: true

class UsersTicketDesk < ApplicationRecord
  belongs_to :ticket_desk
  belongs_to :user
end
