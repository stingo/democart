class OrderItemsController < ApplicationController
  before_action :set_ordering


  def create
    @order_item = @ordering.order_items.new(ordering_params)
    
    @ordering.save
    session[:ordering_id] = @ordering.id

respond_to do |format|
	session[:return_to] ||= request.referer
format.html { redirect_back fallback_location: "/" }
 end
  
  end


  def update
    @order_item = @ordering.order_items.find(params[:id])
    @order_item.update(ordering_params)
    @order_items = current_ordering.order_items



  end

  def destroy
    @order_item = @ordering.order_items.find(params[:id])
    @order_item.destroy
    @order_items = current_ordering.order_items

    respond_to do |format|
format.html { redirect_back fallback_location: "/" }
 end
  end

  private

  def ordering_params
    params.require(:order_item).permit(:ad_id, :quantity)
  end

  def set_ordering
    @ordering = current_ordering
  end
end