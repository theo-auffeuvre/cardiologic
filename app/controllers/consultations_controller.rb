require 'csv'

class ConsultationsController < ApplicationController

  def new
    @consultation = Consultation.new
    @consultation.build_patient
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.general_practitioner_user = current_user
    @mat_file = params[:consultation][:file].tempfile.path unless params[:consultation][:file].nil?
    @data_ecg = upload_convert(@mat_file)
    @data_ecg.shift
    @ecg = Ecg.new(data: @data_ecg.to_json)
    @ecg.patient = @consultation.patient
    raise
    @ecg.save!
    @consultation.save!
  end

  private

  def consultation_params
    params.require(:consultation).permit(patient_attributes: [:first_name, :last_name, :birth_date, :height, :weight])
  end

  def upload_convert(mat_file)
    p mat_file
    system("python3 app/python/converter.py '#{mat_file}'")
    array = []
    CSV.foreach('test.csv') do |line|
      array << [line[0], line[1]]
    end
    return array
  end
 
end
