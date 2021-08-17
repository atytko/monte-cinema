# frozen_string_literal: true

module Override
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_before_action :authenticate_user!, only: :create
  end
end
