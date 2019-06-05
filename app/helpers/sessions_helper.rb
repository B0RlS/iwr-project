# frozen_string_literal: true

# Helper for Session
module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    redirect_to root_path unless logged_in?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Remembers the user to a permanent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end

  def current_user_profile
    current_user.profile.id
  end
end
