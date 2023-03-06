class ConsultationsController < ApplicationController

  def new
    @consultation = Consultation.new
    @consultation.build_patient
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.general_practitioner_user = current_user
    @consultation.save!
  end

  private

  def consultation_params
    params.require(:consultation).permit(patient_attributes: [:first_name, :last_name, :birth_date, :height, :weight])
  end
end
