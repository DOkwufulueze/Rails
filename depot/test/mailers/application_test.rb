require 'test_helper'

class ApplicationTest < ActionMailer::TestCase
  test "application error" do
    mail = ApplicationMailer.send_failure_mail
    assert_equal ":::Application Error", mail.subject
    assert_equal ["daniel.okwufulueze@gmail.com"], mail.to
    assert_equal ["daniel@dealdey.com"], mail.from
    assert_match /Application error occured/, mail.body.encoded
  end
end

