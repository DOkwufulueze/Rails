class StoreController < ApplicationController
  def index
    @time_of_display = Time.now.to_formatted_s(:long)
    @products = Product.order(:title => :asc)
  end
end


