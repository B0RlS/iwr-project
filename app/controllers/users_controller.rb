# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      ProfileCreateService.new(user_id: @user.id).call!
      log_in @user
      flash[:success] = 'Welcome, registration is successful.'
      redirect_to root_path
    else
      flash[:danger] = 'Oops'
    end
  end

  def edit
    @user = User.find(user_params)
    authorize @user
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
