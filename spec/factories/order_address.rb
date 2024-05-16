FactoryBot.define do
  factory :order_address do
    token { "tok_#{Faker::Internet.password(min_length: 25, max_length: 30, mix_case: false)}" }
    post_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.secondary_address }
    phone_number { Faker::Number.number(digits: rand(10..11)) }
  end
end
