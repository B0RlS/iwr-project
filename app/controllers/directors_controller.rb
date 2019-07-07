# frozen_string_literal: true

class DirectorsController < ApplicationController
  def show
    if logged_in?
      authorize User
    else
      redirect_to root_path
      return
    end
    @users = policy_scope(User)
  end

  def update
    @user = User.find(params[:user_id])
    if logged_in?
      if current_user.director?
        update_user(@user)
        return
      end
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

  def update_user(user)
    if user.update_attributes(user_params)
      redirect_to director_path
    else
      flash[:danger] = 'Oops'
    end
  end
end
