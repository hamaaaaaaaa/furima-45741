class Item < ApplicationRecord
  belongs_to :user

  # 商品に画像1枚を添付できるようにする
  has_one_attached :image
end