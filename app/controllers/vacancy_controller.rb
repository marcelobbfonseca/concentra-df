class VacancyController < ApplicationController
  load_and_authorize_resource #parada do cancan. restricao definida no model: ability.
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

      @position_waiting_list = 0
      if @vacancy.waiting_list == true

        @similar_mfs.each do |similar_mf|
          @position_waiting_list += Vacancy.where("modality_filiation_id = ? AND created_at > ? AND waiting_list = true",similar_mf.id,similar_mf.created_at).count
        end

        render json: {waiting_list: @vacancy.waiting_list,position_waiting_list: @position_waiting_list}

      else
        render json: {waiting_list: @vacancy.waiting_list}
      end

    else
      render json: @vacancy.errors, status: :unprocessable_entity
    end
  end

  def transfer
    @email = transfer_params
    @vacancy  = Vacancy.where(user: current_user)
    @recipient = User.where(email: @email)
    if @recipient.count == 1
      @vacancy.user(@recipient)
      render json: 'n deu'
    end
    #   if @vacancy.save
    #     render json: @vacancy
    #   else
    #     render json: @vacancy.errors, status: :unprocessable_entity
    #   end
    # else
    render json: 'nao entrou'
    # end
  end

  private

  def vacancy_params
    params.require(:vacancy).permit(:modality_filiation_id)
  end

  def transfer_params
    params.require(:transfer).permit(:recipient_email)
  end
end