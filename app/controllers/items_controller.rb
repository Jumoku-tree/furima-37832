class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: :edit

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to new_user_session_path unless user_signed_in? && current_user.id == @item.user_id
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if current_user.id == item.user_id
      item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params
      .require(:item)
      .permit(:title, :about, :price, :charge_id, :category_id, :condition_id, :till_id, :prefecture_id, :image)
      .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
