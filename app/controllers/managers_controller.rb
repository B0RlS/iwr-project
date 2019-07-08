# frozen_string_literal: true

class ManagersController < ApplicationController
  def show
    @manager = current_user
    if logged_in?
      authorize @manager
    else
      redirect_to root_path
      return
    end
    @users = User.all
  end
end
