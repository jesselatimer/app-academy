# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
15.times do
  User.create!(:user_name => Faker::Internet.user_name)
end

15.times do |i|
  Poll.create!(:title => Faker::App.name, :author_id => i+1)
end

15.times do |i|
  Question.create!(:text => Faker::Hacker.say_something_smart, :poll_id => i+1)
end

15.times do |i|
  4.times do |j|
    AnswerChoice.create!(:text => Faker::Lorem.sentence, :question_id => i+1)
  end
  Response.create!(:answer_choice_id => (rand(15) + 1), :user_id => i+1)
end
