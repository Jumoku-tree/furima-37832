class OrdersController < ApplicationController
  def index
    @order = Order.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order = Order.new(order_params)
  end
  private

  def order_params
    params.require(:order).merge(item_id: Item.find(params[:item_id]), user_id: current_user.id)
  end
end
