class VacancyController < ApplicationController
  def new
    @modality_filiations = ModalityFiliation.all
    @user = current_user
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)
    @vacancy.user = current_user
    if @vacancy.save
      render nothing: true
    else
      render json: @vacancy.errors, status: :unprocessable_entity
    end
  end

  private

  def vacancy_params
    params.require(:vacancy).permit(:modality_filiation_id)
  end
end