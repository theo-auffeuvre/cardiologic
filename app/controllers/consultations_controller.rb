require 'csv'
require "chartkick"

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
    @peeks = peeks_extractor(@data_ecg)
    @intervals = []
    @peeks.each_with_index do |peek, index|
      @intervals << @peeks[index + 1][0].to_i - peek[0].to_i unless @peeks[index + 1].nil?
    end
    @intervals_in_ms = @intervals.map { |interval| interval*1000/360 }
    @criticity = choose_criticity(@intervals_in_ms)
    @consultation.diagnostic = @criticity
    @ecg = Ecg.new(data: @data_ecg.to_json)
    @ecg.patient = @consultation.patient
    @ecg.save!
    @consultation.save!
    redirect_to consultation_path(@consultation)
  end

  def show
    @consultation = Consultation.find(params[:id])
    @data = JSON.parse(@consultation.patient.ecgs.last.data)
    @message = Message.new
    @consultation.diagnostic = "rouge"


  end

  def index
    @consultations = Consultation.all
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

  def peeks_extractor(data)
    @maxs = []
    tmp_array = []
    inArray = false
    data.each do |item|
        if item[1].to_i > 1127
          if inArray == true
            tmp_array << item
          else
            tmp_array << item
            inArray = true
          end
        else
          if inArray == true
            @maxs << tmp_array
            tmp_array = []
            inArray = false
          end
        end
    end

    @peeks = []
    @maxs.each do |peek|
      @peeks << peek.max
    end
    return @peeks
  end

  def choose_criticity(intervals)
    if intervals.max > 2000
      "red"
    elsif (intervals.sort[-2] - intervals.sort[1]) > 500
      "orange"
    else
      "green"
    end
  end

end
