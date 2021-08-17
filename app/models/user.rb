# frozen_string_literal: true

class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations, dependent: :destroy
  has_many :users_ticket_desks, dependent: :destroy
  belongs_to :user_role
  validates :last_name, presence: true
  validates :first_name, presence: true

  before_validation :assign_default_role, on: :create

  def assign_default_role
    self.user_role = UserRole.default
  end
end
