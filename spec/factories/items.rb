FactoryBot.define do
  factory :item do
    item_name { "MyString" }
    description { "MyText" }
    price { 1 }
    category_id { 1 }
    condition_id { 1 }
    shipping_charge_id { 1 }
    prefecture_id { 1 }
    delivery_day_id { 1 }
    user { nil }
  end
end
