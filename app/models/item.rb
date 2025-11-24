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
end
