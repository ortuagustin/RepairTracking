require 'faker'

User.destroy_all
Customer.destroy_all
Artifact.destroy_all

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

Artifact.create(name: 'Heladera', model: 'PHILCO PHCC340X')
Artifact.create(name: 'Televisor', model: 'SAMSUNG UN49K5500')
Artifact.create(name: 'Lavarropas', model: 'DREAN Next 8.12')
Artifact.create(name: 'Microondas', model: 'ATMA md1728gn')