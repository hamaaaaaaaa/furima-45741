FactoryBot.define do
  factory :user do
    nickname              { "山田太郎" }
    last_name             { "山田" }
    first_name            { "太郎" }
    last_name_kana        { "ヤマダ" }
    first_name_kana       { "タロウ" }
    birth_date            { "1990-01-01" }
    email                 { Faker::Internet.unique.email }
    password              { "test123" }
    password_confirmation { password }
  end
end
