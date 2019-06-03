# frozen_string_literal: true

# Controller for profile
class ProfilesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_profile, only: %i[edit update]
  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update_attributes(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:country_code, :city, :birthday,
                                    :telephone)
  end
end
