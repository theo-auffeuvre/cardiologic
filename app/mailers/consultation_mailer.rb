class ConsultationMailer < ApplicationMailer
  require "prawn"
  require 'tempfile'
  default from: 'contact@cardiologic.eu'

  def send_email(mail_address, consultation, place)


    @cardiologists = Cardiologist.near(place, 2, units: :km).first(5)


    Prawn::Document.generate("printable.pdf") do
      text "Hello World!"
    end
    # @test = testa
    # pdf = WickedPdf.new.pdf_from_url(consultation_url(consultation))

    attachments['printable.pdf'] = File.read("./printable.pdf")

    mail( to: mail_address,
    subject: 'Thanks for nothing!')
    File.delete("./printable.pdf")
  end
end
