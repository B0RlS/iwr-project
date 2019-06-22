# frozen_string_literal: true

class Vacancy
  class PublishController < ApplicationController
    def update
      @vacancy = Vacancy.find(params[:vac_id])
      authorize @vacancy
      @vacancy.update_attributes(publish_params)
      redirect_to @vacancy
    end

    private

    def publish_params
      params.permit(:publish)
    end
  end
end
