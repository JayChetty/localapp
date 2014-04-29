# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    jay  = Owner.create!(
                         email: "jaypaulchetty@gmail.com",
                         password: "password",
                         password_confirmation: "password"
                         )

    jay.businesses.create!(
      name: "BookLa",
      address: 'asdfasdf',
      latitude: 55.95,
      longitude: -3.18,
    )

     jay.businesses.create!(
      name: "FoodLa",
      address: 'qwerqwer',
      latitude: 55.91,
      longitude: -3.28,
    )   