# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destroying users..."
User.destroy_all

puts "Creating users..."

  User.create!(
    first_name: 'John',
    last_name: 'Attend',
    address:'55 Rue Vendôme 69006 Lyon',
    phone:'0403890657',
    speciality: 'general_practitioner',
    doctolib_url: 'doctolib.fr/cardiologue/lyon/marc-ferrini',
    email: 'j.attend@mail.com',
    password: '123456'
  )

User.create!(
  first_name: 'Gregory',
  last_name:  'House',
  address:    '1 Place Bellecour 69002 Lyon',
  phone:      '0403890656',
  speciality: 'cardiologist',
  doctolib_url: 'doctolib.fr/cardiologue/lyon/bernard-pierre',
  email: 'g.house@mail.com',
  password: '123456'
)
puts "Done creating users !"
