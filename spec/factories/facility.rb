FactoryBot.define do
  factory :facility do
    prefecture_id { 1 }
    city          { '札幌市' }
    name          { '札幌市民体育館' }
    area          { 'メインアリーナ' }
    rule          { 'テスト' }
    phone_number  { Faker::Number.leading_zero_number(digits: 11) }
    price         { 1000 }
    association :user
  end
end