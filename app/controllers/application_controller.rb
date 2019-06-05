# frozen_string_literal: true

# Controller for project
class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper
  rescue_from Pundit::NotAuthorizedError do
    redirect_to(root_path)
  end
end
