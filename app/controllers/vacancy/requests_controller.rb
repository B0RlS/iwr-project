# frozen_string_literal: true

class Vacancy < ApplicationRecord
  class RequestsController < ApplicationController
    def index
      if !current_user.nil?
        @requests = Vacancy::Request.includes(:vacancy)
                                    .where(user_id: current_user.id)
      else
        redirect_to root_path
      end
    end

    def create
      @request = Vacancy::Request.new(request_params)
      authorize @request
      if @request.save
        flash[:success] = 'Request successfully sent'
        redirect_to vacancy_path(vac_id: @request.vacancy_id)
      else
        flash[:error] = 'Something went wrong'
        redirect_to root_path
      end
    end

    def update
      @request = Vacancy::Request.find(params[:id])
      authorize @request
      if @request.update_attributes(update_request_params)
        flash[:success] = 'Updated!'
        redirect_to vacancy_path(vac_id: @request.vacancy_id)
      else
        flash[:error] = 'Something went wrong'
        redirect_to root_path
      end
    end

    private

    def request_params
      params.require('request').permit(:vacancy_id, :user_id)
    end

    def update_request_params
      params.require(:request).permit(:approve)
    end
  end
end
