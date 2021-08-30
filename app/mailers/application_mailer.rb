# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'anna.tytko@monterail.com'
  layout 'mailer'
end
