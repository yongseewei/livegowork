# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "elon@musk.com", first_name: "elon", last_name: "musk", password: "elonmusk", gender: "male")
User.create(email: "tony@starkindustries.com", first_name: "tony", last_name: "stark", password: "tonystark", gender: "male")
User.create(email: "bill@nye.com", first_name: "bill", last_name: "nye", password: "billnye", gender: "male")