# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


City.create(name: 'Le Locle', npa: '2400', id: 1)  
City.create(name: 'Neuchâtel', npa: '2300', id: 2)  
City.create(name: 'La Neuveville', npa: '2520', id: 3)  
City.create(name: 'Le Landeron', npa: '2525', id: 4)  
City.create(name: 'Fribourg', npa: '1700', id: 5)  

Restaurant.create(name: 'Hotel de la couronne', description: 'Brasserie', city_id: 5)
Restaurant.create(name: 'Pizzeria Napoli', description: 'Pizzeria napolitaine', city_id: 5)
Restaurant.create(name: 'Pizzeria des pontains', description: 'Pizzeria', city_id: 5)
Restaurant.create(name: 'La dolce vita', description: 'Spécialités italiennes', city_id: 5)
Restaurant.create(name: 'Hotel de l''ours', description: 'Spécialités régionales', city_id: 3)
Restaurant.create(name: 'Hymmmalaya', description: 'Spécialités népalaises', city_id: 3)
Restaurant.create(name: 'Chez Maurice', description: 'Traiteur régional', city_id: 3)
Restaurant.create(name: 'Brasserie de la fontaine', description: 'Brasserie', city_id: 3)
Restaurant.create(name: 'Sakura', description: 'Chinois', city_id: 2)
Restaurant.create(name: 'Pékin express', description: 'Chinois', city_id: 2)