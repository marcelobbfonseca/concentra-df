class VacancyController < ApplicationController
  def new
    @modality_filiations = ModalityFiliation.all
  end

  def create

    @modality_filiation = ModalityFiliation.find(vacancy_params[:modality_filiation_id])
    @modality = Modality.find(@modality_filiation.modality)

    @similar_mfs = ModalityFiliation.where("modality_id = ?",@modality.id)

    @number_of_records = 0
    @similar_mfs.each do |similar_mf|
      @number_of_records += Vacancy.where("modality_filiation_id = ?",similar_mf.id).count
    end

    @vacancy = Vacancy.new(vacancy_params)
    @vacancy.user = current_user

    if @modality.vacancy > @number_of_records # Verifica se tem vaga suficiente
      @vacancy.waiting_list = 0 # Nao entra na lista
    else
      @vacancy.waiting_list = 1 # Entra na lista
    end

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