require 'ostruct'

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order(created_at: :desc)

    # 商品が一つもない場合にダミーを作る
    if @items.empty?
      @items = [
        OpenStruct.new(
          item_name: "商品を出品してね!",
          price: 99999999,
          shipping_charge: OpenStruct.new(name: "税込み"),
          image: nil
        )
      ]
    end
  end

  def show
  @item = Item.find(params[:id])
end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name,
      :description,
      :price,
      :image,
      :category_id,
      :condition_id,
      :shipping_charge_id,
      :prefecture_id,
      :delivery_day_id
    )
  end
end