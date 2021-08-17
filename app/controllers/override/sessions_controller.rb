# frozen_string_literal: true

module Override
  class SessionsController < DeviseTokenAuth::SessionsController
    skip_before_action :authenticate_user!, only: :create
  end
end
