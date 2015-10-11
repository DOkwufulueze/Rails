class ApplicationMailer < ActionMailer::Base
  default from: "daniel@dealdey.com"
  layout 'mailer'

  def send_failure_mail
    mail :to => 'daniel.okwufulueze@gmail.com', :subject => ':::Application Error'
  end
end
