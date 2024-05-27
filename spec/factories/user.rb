FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.unique.email }
    password { 'password' }
  end
end
