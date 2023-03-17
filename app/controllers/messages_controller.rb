class MessagesController < ApplicationController

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @message = Message.new(message_params)
    @message.consultation = @consultation
    @message.user = current_user

    if @message.save
      redirect_to consultation_path(@consultation)
      ConsultationChannel.broadcast_to(
        @consultation,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else render "consultations/show", status: :unprocessable_entity
    end
  end

  def createsandwich
    @consultation = Consultation.last
    @message = Message.new(content: params[:content])
    @message.consultation = @consultation
    @message.user = User.find(current_user.id)

    if @message.save

      ConsultationChannel.broadcast_to(
        @consultation,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
      render "consultations/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end
