FactoryBot.define do
  factory :post do
    user
    content { Faker::Lorem.paragraph_by_chars(number: rand(30..140)) }
  end
end
