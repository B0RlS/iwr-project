# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = 'Gee! Registration is successful! ;-)'
    else
      flash[:danger] = 'Oops! Activation link is invalid. :-('
    end
    redirect_to root_path
  end
end
