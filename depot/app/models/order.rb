class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  # PAYMENT_TYPES = %w(Check Credit\ card Purchase\ Order)
  PAYMENT_TYPES = PaymentType.pluck(:option)


  validates :name, :address, :email, :presence => true
  validates :pay_type, :inclusion => {
                                      :in => PAYMENT_TYPES,
                                      :message => ':::Select a valid Payment type'
                                    }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end



