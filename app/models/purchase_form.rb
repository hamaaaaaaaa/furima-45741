# app/models/purchase_form.rb
class PurchaseForm
  include ActiveModel::Model

  # 保存したいカラムをすべて attr_accessor に書く
  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city, :address, :building, :phone_number,
                :token # PAY.JP導入時に使うカードトークン（今は空でOK）

  # バリデーション（ここでルールを決める）
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "はハイフンを含む形式で入力してください" }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" } # id:1が「---」なら
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10〜11桁の数字で入力してください" }
    # validates :token  # PAYJP導入後に戻す
  end

  # フォームの保存処理（トランザクションでまとめて保存）
  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      # ordersテーブルに購入情報を保存
    order = Order.create!(user_id: user_id, item_id: item_id)

      # addressesテーブルに発送先情報を保存
      Address.create!(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building: building,
        phone_number: phone_number,
         order_id: order.id
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
