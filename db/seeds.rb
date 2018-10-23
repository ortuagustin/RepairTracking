require 'faker'

User.destroy_all

User.create(email: 'ortu.agustin@gmail.com', password: '1234')
User.create(email: 'test@test.com', password: '1234')

ActiveRecord::Base.transaction do
  25.times do |i|
    Customer.create(name: Faker::HarryPotter.unique.character,
                    surname: Faker::HarryPotter.house,
                    phone: "(#{Faker::Number.number(3)})-#{Faker::Number.number(3)}-#{Faker::Number.number(4)}",
                    email: Faker::Internet.unique.email)
  end
end