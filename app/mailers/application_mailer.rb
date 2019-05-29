# frozen_string_literal: true

# Mailer for project
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
