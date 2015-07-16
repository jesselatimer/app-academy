# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'

Cat.create!(
  name: "Miss Kitty Fantastico",
  birth_date: Date.new(2001, 3, 7),
  sex: 'F',
  color: 'white',
  description: 'The best kitty ever.'
)

Cat.create!(
  name: "Mr. Kitty",
  birth_date: Date.new(2007, 6, 12),
  sex: 'M',
  color: 'black',
  description: 'Drunk little kitty.'
)

Cat.create!(
  name: "The Nameless One",
  birth_date: Date.new(1000, 1, 1),
  sex: 'M',
  color: 'orange'
)

CatRentalRequest.create!(
  cat_id: 1,
  start_date: Date.new(2015, 7, 14),
  end_date: Date.new(2015, 8, 14),
  status: "APPROVED"
)

CatRentalRequest.create!(
  cat_id: 1,
  start_date: Date.new(2015, 9, 14),
  end_date: Date.new(2015, 10, 14),
  status: "APPROVED"
)

CatRentalRequest.create!(
  cat_id: 2,
  start_date: Date.new(2015, 7, 14),
  end_date: Date.new(2015, 7, 15)
)
