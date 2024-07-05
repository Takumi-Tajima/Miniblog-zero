5.times do |_n|
  user = User.create!(
    name: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8)
  )
  Post.create!(
    user_id: user.id,
    content: Faker::Lorem.paragraph
  )
end
