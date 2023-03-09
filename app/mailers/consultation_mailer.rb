class ConsultationMailer < ApplicationMailer
  default from: 'contact@cardiologic.eu'

  def send_email()
    mail( to: "theo.auffeuvre@gmail.com",
    subject: 'Thanks for nothing!' )
  end
end
