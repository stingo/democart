class CartController < ApplicationController
  def show
    @order_items = current_ordering.order_items
  end
end
