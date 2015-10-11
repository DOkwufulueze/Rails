require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["daniel.okwufulueze@gmail.com"], mail.to
    assert_equal ["daniel@dealdey.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["daniel.okwufulueze@gmail.com"], mail.to
    assert_equal ["daniel@dealdey.com"], mail.from
    assert_match /<td>1&times;<\/td>\r\n  <td> Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

  test "shipping date updated" do
    mail = OrderNotifier.ship_date_updated(orders(:one))
    assert_equal "Ship Date Changed", mail.subject
    assert_equal ["daniel.okwufulueze@gmail.com"], mail.to
    assert_equal ["daniel@dealdey.com"], mail.from
    assert_match /Your shipping date is now 2017-07-02 00:00:00/, mail.body.encoded
  end

end
