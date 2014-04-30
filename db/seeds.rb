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
      address: '6 Merchiston Park Edinburgh Scotland EH104PN'
    )

     jay.businesses.create!(
      name: "FoodLa",
      address: '43 Warrender Park Terrace Edinburgh Scotland'
    )   