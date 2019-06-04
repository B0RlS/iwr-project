# frozen_string_literal: true

# Helper for User
module UsersHelper
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_path) unless @user == current_user
  end

  def correct_profile
    @profile = Profile.find(params[:id])
    redirect_to(root_path) unless @profile == current_user.profile
  end

  def current_user_profile
    current_user.profile.id
  end
end
