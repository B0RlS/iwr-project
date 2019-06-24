# frozen_string_literal: true

class VacanciesController < ApplicationController
  def index
    @vacancies = Vacancy.where(publish: true)
    authorize @vacancies
  end

  def show
    @vacancy = Vacancy.find(params[:vac_id])
    authorize @vacancy
    @attributes = Vacancy::Attribute.where(vacancy_id: params[:vac_id])
    @request = Vacancy::Request.where(user_id: current_user.id,
                                      vacancy_id: @vacancy.id)
  end

  def new
    @vacancy = Vacancy.new
    authorize @vacancy
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)
    authorize @vacancy
    @vacancy.country = @vacancy.country_name if @vacancy.country.present?
    if @vacancy.save
      redirect_to @vacancy
    else
      render :new
    end
  end

  def update
    @vacancy = Vacancy.find(params[:vac_id])
    authorize @vacancy
    @vacancy.update_attributes(update_vacancy_params)
  end

  def destroy
    @vacancy = Vacancy.find(params[:vac_id])
    authorize @vacancy
    @vacancy.destroy

    redirect_to root_path
  end

  private

  def vacancy_params
    params.require(:vacancy).permit(:country, :city, :name, :specialty_id,
                                    :description, :user_id)
  end

  def update_vacancy_params
    params.require(:vacancy).permit(:name, :specialty_id, :description)
  end
end
