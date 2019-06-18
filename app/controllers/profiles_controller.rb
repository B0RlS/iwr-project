# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:user_id])
    authorize @profile
    @user = current_user
    @skills = Skill.all
    @skill_levels = User::SkillLevel.where(user_id: @user.id)
  end

  def edit
    @profile = Profile.find(params[:user_id])
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:user_id])
    authorize @profile

    if @profile.update_attributes(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:country_code, :city, :birthday,
                                    :telephone, :avatar, :resume)
  end
end
