# frozen_string_literal: true

# Controller for sessions
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      login_account user
    else
      flash.now[:danger] = 'Invalid email or password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_account(user)
    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_to user
  end
end
