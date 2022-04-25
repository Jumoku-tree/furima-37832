class OrdersController < ApplicationController
  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def new
  end

  def create
    # binding.pry
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  private

  def order_params
    params
    .require(:order_address)
    .permit(:building, :house_number, :municipality, :prefecture_id, :postal_code, :phone_number, :item_id, :user_id)
    .merge(item_id: @item.id, user_id: current_user.id)
  end

end
