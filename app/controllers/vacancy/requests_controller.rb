# frozen_string_literal: true

class Vacancy
  class RequestsController < ApplicationController
    def index
      if !current_user.nil?
        @requests = Vacancy::Request.where(user_id: current_user.id)
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

    private

    def request_params
      params.require('request').permit(:vacancy_id, :user_id)
    end
  end
end
