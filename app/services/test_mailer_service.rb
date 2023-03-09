# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

class TestMailerService
  def initialize
  end

  def call
    from = SendGrid::Email.new(email: 'theo.auffeuvre@gmail.com', name: "test")
    p from
    to = SendGrid::Email.new(email: 'theo.auffeuvre@gmail.com', name: "test")
    p to
    subject = 'Sending with SendGrid is Fun'
    content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end