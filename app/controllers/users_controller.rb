# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    @user = UserCreateService.new(user_params).call
    redirect_to root_path if log_in @user
  end

  def update
    @user = User.find(params[:user_id])
    authorize @user
    if @user.update_attributes(user_params)
      redirect_to profile_path(user_profile_id)
    else
      flash[:danger] = 'Oops'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    authorize @user
    @user.destroy

    redirect_to root_path
  end

  def email_uniq?
    if User.find_by(email: request.params['email'].to_s).nil?
      render status: '404', json: { message: '' }
    else
      render status: '204', json: { message: '' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname,
                                 :email, :password, :password_confirmation,
                                 skill_levels_attributes:
                                 %i[user_id skill_id level id])
  end

  def user_profile_id
    @user.profile.id
  end
end
