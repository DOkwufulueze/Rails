class StoreController < ApplicationController
  skip_before_action :authorize
  
  include CountAccess
  before_action :set_counter, :only => [:index] 

  include CurrentCart
  before_action :set_cart
  def index
    @time_of_display = Time.now.to_formatted_s(:long)
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    else
      @products = Product.order(:title => :asc)
    end
  end
end


