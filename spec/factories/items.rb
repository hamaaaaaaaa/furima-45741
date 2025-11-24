FactoryBot.define do
  factory :item do
    item_name { "テスト商品" }
    description { "これはテスト用の商品説明です" }
    price { 1000 }
    category_id { 2 }        # ---(1) 以外
    condition_id { 2 }
    shipping_charge_id { 2 }
    prefecture_id { 2 }
    delivery_day_id { 2 }
    association :user        # user を作成して紐付け

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
