class ItemsController < ApplicationController
  # ログインしていないユーザーはログインページへリダイレクト
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      redirect_to root_path  # 出品成功 → トップページ
    else
      render :new  # バリデーションエラー → 出品ページに戻る
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :item_name, :description, :price, :image,
      :category_id, :condition_id, :shipping_charge_id,
      :prefecture_id, :delivery_day_id
    )
  end
end
