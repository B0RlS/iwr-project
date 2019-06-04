# frozen_string_literal: true

# Home Controller class
class HomeController < ApplicationController
  def index
    if logged_in?
      render layout: 'application'
    else
      @user = User.new
      render layout: 'welcome'
    end
  end
end
