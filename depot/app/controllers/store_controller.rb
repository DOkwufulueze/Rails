class StoreController < ApplicationController
  include CountAccess
  before_action :set_counter, :only => [:index] 

  def index
    @time_of_display = Time.now.to_formatted_s(:long)
    @products = Product.order(:title => :asc)
  end
end


