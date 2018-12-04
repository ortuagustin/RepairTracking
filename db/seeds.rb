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
                    phone: "221 #{Faker::Number.number(3)}-#{Faker::Number.number(4)}",
                    email: Faker::Internet.unique.email)
  end
end

heladera = Artifact.new(name: 'Heladera', model: 'PHILCO PHCC340X')
heladera.pieces << Piece.new(name: 'Motor', cost: Faker::Number.decimal(2, 2))
heladera.pieces << Piece.new(name: 'Compresor', cost: Faker::Number.decimal(2, 2))
heladera.pieces << Piece.new(name: 'Condensador', cost: Faker::Number.decimal(2, 2))
heladera.pieces << Piece.new(name: 'Termostato', cost: Faker::Number.decimal(2, 2))
heladera.pieces << Piece.new(name: 'Evaporador', cost: Faker::Number.decimal(2, 2))

10.times do |i|
  Task.create(
    name: Faker::Lorem.sentence(3),
    description: Faker::Lorem.sentence(5),
    cost: Faker::Number.decimal(2, 2),
    artifact: heladera
  )
end

heladera.save!

tv = Artifact.new(name: 'Televisor', model: 'SAMSUNG UN49K5500')
tv.pieces << Piece.new(name: 'Pantalla', cost: Faker::Number.decimal(2, 2))
tv.pieces << Piece.new(name: 'Antena', cost: Faker::Number.decimal(2, 2))
tv.pieces << Piece.new(name: 'Flyback', cost: Faker::Number.decimal(2, 2))
tv.pieces << Piece.new(name: 'Fuente de alimentación', cost: Faker::Number.decimal(2, 2))
tv.save!

10.times do |i|
  Task.create(
    name: Faker::Lorem.sentence(3),
    description: Faker::Lorem.sentence(5),
    cost: Faker::Number.decimal(2, 2),
    artifact: tv
  )
end

lavarropas = Artifact.new(name: 'Lavarropas', model: 'DREAN Next 8.12')
lavarropas.pieces << Piece.new(name: 'Motor', cost: Faker::Number.decimal(2, 2))
lavarropas.pieces << Piece.new(name: 'Filtro', cost: Faker::Number.decimal(2, 2))
lavarropas.pieces << Piece.new(name: 'Resistencia', cost: Faker::Number.decimal(2, 2))
lavarropas.pieces << Piece.new(name: 'Tambor', cost: Faker::Number.decimal(2, 2))
lavarropas.pieces << Piece.new(name: 'Microprocesador', cost: Faker::Number.decimal(2, 2))
lavarropas.pieces << Piece.new(name: 'Correa', cost: Faker::Number.decimal(2, 2))
lavarropas.save!

10.times do |i|
  Task.create(
    name: Faker::Lorem.sentence(3),
    description: Faker::Lorem.sentence(5),
    cost: Faker::Number.decimal(2, 2),
    artifact: lavarropas
  )
end

microodas = Artifact.new(name: 'Microondas', model: 'ATMA md1728gn')
microodas.pieces << Piece.new(name: 'Ventilador', cost: Faker::Number.decimal(2, 2))
microodas.pieces << Piece.new(name: 'Calefactor', cost: Faker::Number.decimal(2, 2))
microodas.pieces << Piece.new(name: 'Capacitador', cost: Faker::Number.decimal(2, 2))
microodas.pieces << Piece.new(name: 'Temporizador', cost: Faker::Number.decimal(2, 2))
microodas.pieces << Piece.new(name: 'Dispersor de cost: ondas', cost: Faker::Number.decimal(2, 2))
microodas.pieces << Piece.new(name: 'Ánodo', cost: Faker::Number.decimal(2, 2))
microodas.save!

10.times do |i|
  Task.create(
    name: Faker::Lorem.sentence(3),
    description: Faker::Lorem.sentence(5),
    cost: Faker::Number.decimal(2, 2),
    artifact: microodas
  )
end