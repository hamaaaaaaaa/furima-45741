class PurchaseForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city, :address, :building, :phone_number,
                :token

  # 必須項目
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
    # validates :token
  end

  # 個別バリデーション
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "はハイフンを含む形式で入力してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10〜11桁の数字で入力してください" }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)

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
