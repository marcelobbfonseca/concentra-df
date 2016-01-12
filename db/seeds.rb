# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#vacancies = Vacancy.create[{}]
# => Modality
#      t.string :name
#      t.integer :vacancy
#
Modality_filiation.create(modality_id: 1, filiation_id:1, name: 'Bumbum guloso', price: 8000 )
Modality_filiation.create(modality_id: 2, filiation_id:2, name: 'Bumbum Poderoso', price: 8001 )
Modality_filiation.create(modality_id: 3, filiation_id:3, name: 'Engolidor de espadas', price: 2 ) 

Modality.create(name: 'Bumbum guloso', vacancy: 1)
Modality.create(name: 'Bumbum poderoso', vacancy: 2)
Modality.create(name: 'Engolidor de espadas', vacancy: 3)