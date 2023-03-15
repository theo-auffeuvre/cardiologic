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
    @intervals_in_ms = get_intervals(@peeks)
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
    @peeks = peeks_extractor(@data)

    # @peeks_QS = peeks_inverse_extractor(@data)
    @intervals_in_ms = get_intervals(@peeks)

  end

  def index
    @consultations = Consultation.all
  end

  def send_mail
    ConsultationMailer.send_email(params[:mail]).deliver_later
  end

  def search_cardio

    @consultation = Consultation.find(params[:consultation_id])
    myplace = "#{params[:place]}"
    @cardiologists = Cardiologist.near(myplace, 2, units: :km).first(5)
    @cardiologists.map do |cardio|
      cardio.attributes
    end
    respond_to do |format|
      format.html
      format.text { render partial: "consultations/cardiologists", locals: {cardiologists: @cardiologists}, formats: [:html] }
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(patient_attributes: [:first_name, :last_name, :birth_date, :height, :weight])
  end

  def upload_convert(mat_file)
    # system("python3 app/python/converter.py '#{mat_file}'")
    array = []
    CSV.foreach(mat_file) do |line|
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
      @peeks << peek.max_by{|k| k[1] }
    end

    return @peeks
  end

  def peeks_inverse_extractor(data)
    @mins = []
    tmp_array = []
    inArray = false
    data.each do |item|
        if item[1].to_i < 942
          if inArray == true
            tmp_array << item
          else
            tmp_array << item
            inArray = true
          end
        else
          if inArray == true
            @mins << tmp_array
            tmp_array = []
            inArray = false
          end
        end
    end

    @peeks_inverse = []
    @mins.each do |peek_inverse|
      @peeks_inverse << peek_inverse.min
    end

    @peeks_QS = @peeks_inverse.each_slice(3).to_a.map { |peek_inverse| { Q: peek_inverse[0], S: peek_inverse[1] } }

    return @peeks_QS
  end

  def get_intervals(peeks)
    intervals = []
    peeks.each_with_index do |peek, index|
      intervals << peeks[index + 1][0].to_i - peek[0].to_i unless peeks[index + 1].nil?
    end

    @intervals_in_ms = intervals.map { |interval| interval*1000/360 }
    return @intervals_in_ms
  end

  def get_intervals_QS(peeks)
    intervals = []
    peeks.each_with_index do |peek, index|
      intervals << peek[:S][0].to_i - peek[:Q][0].to_i
    end
    @intervals_in_ms_QS = intervals.map { |interval| interval*1000/360 }
    return @intervals_in_ms_QS
  end


  def choose_criticity(intervals)
    if intervals.max > 2000
      "red"
    elsif intervals.max < 500
      "red"
    elsif (intervals.max - intervals.min) > 446
      "orange"
    else
      "green"
    end
  end

  def send_mail
    ConsultationMailer.send_email().deliver_later
  end

end
