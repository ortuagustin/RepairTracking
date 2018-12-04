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
heladera.pieces << Piece.new(name: 'Motor')
heladera.pieces << Piece.new(name: 'Compresor')
heladera.pieces << Piece.new(name: 'Condensador')
heladera.pieces << Piece.new(name: 'Termostato')
heladera.pieces << Piece.new(name: 'Evaporador')
heladera.save!

tv = Artifact.new(name: 'Televisor', model: 'SAMSUNG UN49K5500')
tv.pieces << Piece.new(name: 'Pantalla')
tv.pieces << Piece.new(name: 'Antena')
tv.pieces << Piece.new(name: 'Flyback')
tv.pieces << Piece.new(name: 'Fuente de alimentación')
tv.save!

lavarropas = Artifact.new(name: 'Lavarropas', model: 'DREAN Next 8.12')
lavarropas.pieces << Piece.new(name: 'Motor')
lavarropas.pieces << Piece.new(name: 'Filtro')
lavarropas.pieces << Piece.new(name: 'Resistencia')
lavarropas.pieces << Piece.new(name: 'Tambor')
lavarropas.pieces << Piece.new(name: 'Microprocesador')
lavarropas.pieces << Piece.new(name: 'Correa')
lavarropas.save!

microodas = Artifact.new(name: 'Microondas', model: 'ATMA md1728gn')
microodas.pieces << Piece.new(name: 'Ventilador')
microodas.pieces << Piece.new(name: 'Calefactor')
microodas.pieces << Piece.new(name: 'Capacitador')
microodas.pieces << Piece.new(name: 'Temporizador')
microodas.pieces << Piece.new(name: 'Dispersor de ondas')
microodas.pieces << Piece.new(name: 'Ánodo')

microodas.save!