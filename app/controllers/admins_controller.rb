# frozen_string_literal: true

class AdminsController < ApplicationController
  def show
    if logged_in?
      authorize User
    else
      redirect_to root_path
      return
    end
    @users = User.all
  end

  def destroy
    @user = User.find(params[:format])
    if logged_in?
      authorize @user
    else
      redirect_to root_path
      return
    end
    log_out_user @user
    @user.destroy
  end

  def update
    @user = User.find(params[:format])
    if logged_in?
      authorize @user
    else
      redirect_to root_path
      return
    end
    update_user(@user)
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

  def update_user(user)
    if user.update_attributes(user_params)
      redirect_to admin_path
    else
      flash[:danger] = 'Oops'
    end
  end
end
