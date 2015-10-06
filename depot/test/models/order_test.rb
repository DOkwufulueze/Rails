require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :orders
  # test "the truth" do
  #   assert true
  # end

  test "should create order" do
    order = orders(:one) # Order.new(:name => orders(:one).name, :address => orders(:one).address, :email => orders(:one).email, :pay_type => orders(:one).pay_type)
    assert order.valid?, "Invalid Order"
    # assert_equal ":::Select a valid Payment type", order.errors[:pay_type], ":::Unexpected Error Message"
  end
end

