# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:user_id])
    authorize @profile
    @user = current_user
    @edit_skill_levels = Skill.left_join_skill_levels(@user.id)
                              .group_by(&:sphere)
    @show_skill_levels = Skill.inner_join_skill_levels(@user.id)
                              .group_by(&:sphere)
    @education = User::Education.find_by(user_id: @user.id)
  end

  def update
    @profile = Profile.find(params[:user_id])
    authorize @profile

    if @profile.update_attributes(profile_params)
      redirect_to @profile
    else
      redirect_to root_path
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:country_code, :city, :birthday,
                                    :telephone, :avatar, :resume)
  end
end
