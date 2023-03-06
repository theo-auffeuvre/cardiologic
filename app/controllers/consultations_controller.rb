class ConsultationsController < ApplicationController

  def new
    @consultation = Consultation.new
    @consultation.build_patient
  end

  def create
    raise
    @consultation = Consultation.new(consultation_params)
    @consultation.save!
    raise
  end

  private

  def consultation_params
    params.require(:consultation).permit(patients_attributes: [:first_name, :last_name, :birth_date, :height, :weight])
  end
end
