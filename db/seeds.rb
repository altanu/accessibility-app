# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Seeding DB'
puts 'Seeding users'

User.destroy_all
User.create!(first_name: 'John', last_name:'Xu', email: 'johnbxu@gmail.com', phone_number: 1234567, password: 'abc', password_confirmation: 'abc')
User.create!(first_name: 'Altan', last_name:'Unsal', email: 'altanunsal@gmail.com', phone_number: 1234567, password: 'abc', password_confirmation: 'abc')
User.create!(first_name: 'Louis', last_name:'Riehl', email: 'louisriehl@gmail.com', phone_number: 1234567, password: 'abc', password_confirmation: 'abc')

puts 'Seeding locations'
Location.destroy_all
Location.create!(house_number: 1, street: 'Test St.', wheelchair: true, bathroom: true, parking: true, coordinates: '90.123,90.123')
Location.create!(house_number: 2, street: 'Test St.', wheelchair: false, bathroom: false, parking: false, coordinates: '90.555,90.555')
Location.create!(house_number: 3, street: 'Test St.', wheelchair: true, bathroom: false, parking: false, coordinates: '90.999,90.999')

puts 'Seeding contacts'
Contact.destroy_all
users = User.all
users.each do |user|
  user.contacts.create!(first_name: 'test1', last_name: 'test1', email: 'test1@test.test', phone_number: 1234567, emergency: true)
  user.contacts.create!(first_name: 'test2', last_name: 'test2', email: 'test2@test.test', phone_number: 1234567, emergency: true)
  user.contacts.create!(first_name: 'test3', last_name: 'test3', email: 'test3@test.test', phone_number: 1234567, emergency: true)
end

puts 'Seeding reviews (no reviews yet)'
puts 'Seeding trips (no trips yet)'
