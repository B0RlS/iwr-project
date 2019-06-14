# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @profile = authorize Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:id])
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
                                    :telephone, :avatar)
  end
end
