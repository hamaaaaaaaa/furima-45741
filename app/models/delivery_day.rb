# app/models/delivery_day.rb
class DeliveryDay < ActiveHash::Base
  # ActiveHashのアソシエーションを使えるようにする
  include ActiveHash::Associations
  has_many :items  # Itemモデルとの関連付け

  # 発送までの日数データの定義
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '1~2日で発送' },
    { id: 3, name: '2~3日で発送' },
    { id: 4, name: '4~7日で発送' }
  ]
end
