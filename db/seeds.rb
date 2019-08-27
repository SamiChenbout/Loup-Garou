# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Character.destroy_all

Character.new(name: "loup", description: "Il est méchant").save
Character.new(name: "loup", description: "Il est méchant").save
Character.new(name: "voyante", description: "Il est gentil").save
Character.new(name: "sorciere", description: "Il est gentil").save
Character.new(name: "chasseur", description: "Il est chiant").save
Character.new(name: "cupîdon", description: "Il est gniangnian").save
