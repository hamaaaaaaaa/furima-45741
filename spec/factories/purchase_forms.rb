FactoryBot.define do
  factory :purchase_form do
    postal_code     { "123-4567" }
    prefecture_id   { 2 }
    city            { "大阪市" }
    address         { "1-1" }
    building        { "建物名" }
    phone_number    { "09012345678" }
    token           { "tok_abcdefghijk00000000000000000" }
  end
end
