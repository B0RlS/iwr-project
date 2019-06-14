# frozen_string_literal: true

class Vacancy
  class AttributesController < ApplicationController
    def edit
      @attribute = Vacancy::Attribute.find(params[:attr_id])
      authorize @attribute
    end

    def create
      @attribute = Vacancy::Attribute.new(attribute_params)
      authorize @attribute
      @attribute.save
    end

    def update
      @attribute = Vacancy::Attribute.find(params[:attr_id])
      authorize @attribute
      if @attribute.update_attributes(attribute_params)
        redirect_to vacancy_path(vac_id: @attribute.vacancy_id)
      else
        render :edit
      end
    end

    def destroy
      @attribute = Vacancy::Attribute.find(params[:attr_id])
      authorize @attribute
      @attribute.destroy
    end

    private

    def attribute_params
      params.require(:vacancy_attribute).permit(:attr_type, :name, :important,
                                                :vacancy_id)
    end

    def vacancy_id(attribute)
      attribute.vacancy.id
    end
  end
end
