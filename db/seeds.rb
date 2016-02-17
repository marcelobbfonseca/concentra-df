# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Filiation.create(name: 'EJ Federada')
Filiation.create(name: 'EJ Não-Federada')
Modality.create(name: 'Hotel', vacancy: 100)
Modality.create(name: 'Teste com 5 vagas', vacancy: 5)
Modality.create(name: 'Teste com 1 vaga', vacancy: 1)
ModalityFiliation.create(modality_id: 1, filiation_id: 1, name: 'EJ Federada Hotel', price: 350)
ModalityFiliation.create(modality_id: 1, filiation_id: 2, name: 'EJ Não Federada Hotel', price: 370)
ModalityFiliation.create(modality_id: 2, filiation_id: 1, name: 'Teste com 5 vagas EJ Federada', price: 170)
ModalityFiliation.create(modality_id: 2, filiation_id: 2, name: 'Teste com 5 vagas EJ Não Federada', price: 190)
ModalityFiliation.create(modality_id: 3, filiation_id: 1, name: 'Teste com 1 vaga EJ Federada', price: 190)
ModalityFiliation.create(modality_id: 3, filiation_id: 2, name: 'Teste com 1 vaga EJ Não Federada', price: 210)
#User.create(password: '12345678', email: 'admin@concentradf.com.br',admin: true)

manolo = User.find_by_email("pau@gmail.com")
Complement.create(name: 'Paulo Guina', cpf: '82797256360', user_id: manolo.id)
Vacancy.create(user_id: 1, modality_filiation_id: 1, waiting_list: false)

