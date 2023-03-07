class MessagesController < ApplicationController

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @message = Message.new(message_params)
    @message.consultation = @consultation
    @message.user = current_user

    if @message.save
      redirect_to consultation_path(@consultation)
    else render "consultations/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)

  end


end
