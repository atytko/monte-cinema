# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :role_id, :email
  has_many :reservations
  has_many :users_ticket_desks
  belongs_to :user_role
end
