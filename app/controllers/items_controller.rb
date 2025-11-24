class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new
  end

  def create
    # 入力された情報をもとにItemインスタンスを作成
    @item = Item.new(item_params)
    @item.user = current_user # 出品者情報として現在のユーザーを紐付け

    # バリデーションを通すかどうかで処理を分岐
    if @item.save
      redirect_to root_path  # 保存成功 → トップページへ
    else
      render :new           # 保存失敗 → 出品ページに戻す（入力内容は保持）
    end
  end

  private

  # Strong Parametersで許可する属性を指定
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