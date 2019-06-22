# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper
  rescue_from Pundit::NotAuthorizedError do
    redirect_to(root_path)
  end
end
