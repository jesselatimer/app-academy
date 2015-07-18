# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

usernames = []

6.times do
  username = Faker::Internet.user_name
  User.create!(username: username, password: "password")
  usernames << username
end

3.times do |sub_idx|
  subx = Sub.create!(title: Faker::App.name, description: Faker::Hacker.say_something_smart)
  5.times do
    post = Post.create!(title: Faker::Hacker.ingverb + " " + Faker::Hacker.noun, author_id: (rand(6) + 1), content: Faker::Company.catch_phrase)
    PostSub.create!(post_id: post.id, sub_id: subx.id)
  end
end

4.times do
  ModSub.create!(username: usernames.sample, sub_id: (rand(3) + 1))
end
