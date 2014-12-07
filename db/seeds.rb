user = User.create(email: "michael.squitieri@gmail.com",
                   first_name: "Michael",
                   last_name: "Squitieri",
                   password: "password",
                   password_confirmation: "password")

list = List.create(title: "My Birthday List",
                   start_date: Time.now - 1.month,
                   end_date: Time.now + 1.month,
                   user: user)

5.times do
  Item.create(list: list,
              title: Faker::Commerce.product_name,
              price: Faker::Commerce.price,
              image: Faker::Company.logo,
              link: Faker::Internet.url,
              notes: Faker::Lorem.sentence(3),
              quantity: Faker::Number.digit,
              priority: Faker::Number.digit)
end