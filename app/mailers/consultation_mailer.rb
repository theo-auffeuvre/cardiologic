class ConsultationMailer < ApplicationMailer
  require "prawn"
  require 'tempfile'
  default from: 'contact@cardiologic.eu'

  def send_email(mail_address)
    Prawn::Document.generate("printable.pdf") do
      text "Hello World!"
    end

    # attachment = SendGrid::Attachment.new
    # attachment.content = 'BwdW'
    # attachment.type = 'application/pdf'
    # attachment.filename = 'printable.pdf'
    # attachment.disposition = 'inline'
    # attachment.content_id = 'printable'
    attachments['printable.pdf'] = File.read("./printable.pdf")


    mail( to: mail_address,
    subject: 'Thanks for nothing!')
  end
end
