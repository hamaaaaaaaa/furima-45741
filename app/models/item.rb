class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # ActiveHash
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :delivery_day

  # ActiveStorage
  has_one_attached :image

  # User
  belongs_to :user

  # バリデーション
  validates :image, presence: true
  validates :item_name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_charge_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_day_id, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end