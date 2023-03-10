class ConsultationMailer < ApplicationMailer
  require "prawn"
  require 'tempfile'
  default from: 'contact@cardiologic.eu'

  def send_email(mail_address)
    Prawn::Document.generate("printable.pdf") do
      text "Hello World!"
    end

    attachments['printable.pdf'] = File.read("./printable.pdf")

    mail( to: mail_address,
    subject: 'Thanks for nothing!')
    File.delete("./printable.pdf")
  end
end
