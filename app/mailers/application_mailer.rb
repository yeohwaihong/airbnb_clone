class ApplicationMailer < ActionMailer::Base
  default from: "abc@gmail.com"
  layout 'mailer'
end
