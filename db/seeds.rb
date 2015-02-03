# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#

# airlines = [{name: 'Aeromexico POOL'},{name: 'Sol Lineas Aereas'},{name: 'American Airlines'},{name: 'Air Canada'},{name: 'Air France'},{name: 'Aeromexico'},{name: 'Aerolineas Argentinas'},{name: 'Avianca'},{name: 'Alitalia'},{name: 'British Airways'},{name: 'Copa Airlines'},{name: 'Continental Airlines'},{name: 'Cubana de aviación'},{name: 'Delta Airlines'},{name: 'Emirates'},{name: 'Iberia'},{name: 'TAM Linhas Aereas'},{name: 'LAN'},{name: 'Lufthansa'},{name: 'Swiss Air Lines'},{name: 'El Al'},{name: 'Malaysia Airlines'},{name: 'Andes'},{name: 'Qantas'},{name: 'Qatar'},{name: 'South African Airways'},{name: 'TACA'},{name: 'TAP Air Portugal'},{name: 'United Airlines'},{name: 'Air Europa'},{name: 'Aerochaco'},{name: 'Turkish Airlines'},{name: 'GOL'},{name: 'Conviasa'},{name: 'Sky airlines'},{name: 'Korean Airline'},{name: 'KL'},{name: 'Sol Lineas Aereas Paraguay'},{name: 'BOA'},{name: 'Singapore Airlines'},{name: 'HAHN AIR '},{name: 'TAME'},]

# airlines.each do | a |
#     Airline.create(name: a[:name])
# end 

20.times { |n| 
    Condition.create(airline: Airline.first, start_date:Date.today(), end_date: Date.today()+n, promotions:[Promotion.create(bank: Bank.first, credit_card: CreditCard.first, quota: "12", bin:"1234")], legal_description: "Descripcion legal #{n}")
}

