# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
colors = %w(black white orange brown)

15.times do |i|
  Cat.create!(
    birth_date: Faker::Date.backward(1000),
    name: Faker::Name.first_name,
    color: colors.sample,
    sex: ['M', 'F'].sample,
    description: Faker::Name.title,
    user_id: rand(15) + 1
  )
  3.times do
    CatRentalRequest.create!(
      start_date: Faker::Date.between(Faker::Date.backward(7), Date.today),
      end_date: Faker::Date.between(Date.tomorrow, Faker::Date.forward(7)),
      cat_id: (i + 1)
    )
  end
end

15.times do
  User.create(
    user_name: Faker::Internet.user_name,
    password: 'password',
  )
end
