FactoryBot.define do
  factory :post do
    user
    content { Faker::Alphanumeric.alpha(number: 30) }
  end
end
