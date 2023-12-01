# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.new
user.email = "admin@track.com"
user.password = "test123"
user.password_confirmation = "test123"
user.is_active = true
user.save!



#delivary_partner
user = User.new
user.first_name = "delivary"
user.last_name = "partner"
user.email = "dp@track.com"
user.role = "delivery_partner"
user.password = "test123"
user.password_confirmation = "test123"
user.is_active =  true
user.save!

user = User.new
user.first_name = "customer"
user.last_name = "partner"
user.email = "cp@track.com"
user.role = "delivery_partner"
user.password = "test123"
user.password_confirmation = "test123"
user.is_active =  true
user.save!

user = User.new
user.first_name = "customer"
user.last_name = "partner"
user.email = "cp1@track.com"
user.role = "customer"
user.password = "test123"
user.password_confirmation = "test123"
user.is_active =  true
user.save!