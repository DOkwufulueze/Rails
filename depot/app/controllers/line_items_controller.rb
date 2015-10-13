class LineItemsController < ApplicationController
  skip_before_action :authorize, :only => [:create]

  include CurrentCart
  before_action :set_cart, :only => [:set_line_item, :create]

  before_action :set_line_item, :only => [:show, :edit, :update, :destroy, :decrement_line_item]

  # GET /line_items
  # GET /line_items.json
  def index
    @time_of_display = Time.now.to_formatted_s(:long)
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id, product.price)
    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to store_url }
        format.js { @current_item = @line_item }
        format.json { render :action => :show, :status => :created, :location => @line_item }
      else
        format.html { render :action => :new }
        format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to store_url, notice: "Line item was successfully Updated." }
        format.js {}
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    if @line_item.cart
      message = @line_item.product.try(:title) ? "#{@line_item.product.try(:title)} Was successfully removed from your Cart" : ""
      @line_item.destroy
      update_cart
      respond_to do |format|
        format.html { redirect_to store_url, notice: "Line item #{@line_item.product.try(:title)} was successfully deleted." }
        format.js {}
        format.json { head :no_content }
      end
    else
      @line_item.destroy
      respond_to do |format|
        format.html { redirect_to store_url, :notice => ":::Item successfully deleted." }
        format.js {}
        format.json { head :no_content }
      end
    end
  end

  def update_cart
    cart_object = @line_item.cart
    unless cart_object.line_items.length > 0
      cart_object.destroy
    end
    
  end

  def decrement_line_item
    @line_item.quantity, new_quantity = @line_item.quantity - 1, @line_item.quantity - 1
    if new_quantity == 0
      destroy
    else
      respond_to do |format|
        if @line_item.update(:quantity => new_quantity)
          format.html { redirect_to store_url, notice: "Line item #{@line_item.product.title} was successfully decremented." }
          format.js {}
          format.json { render :show, status: :ok, location: @line_item }
        else
          format.html { render :edit }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
      # params[:line_item]
    end
end

