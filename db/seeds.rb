# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Player.destroy_all
Character.destroy_all
Game.destroy_all
User.destroy_all

puts 'Seeding characters...'
loup1 = Character.new(name: "loup", description: "Il est méchant")
loup2 = Character.new(name: "loup", description: "Il est méchant")
voyante = Character.new(name: "voyante", description: "Il est gentil")
sorciere = Character.new(name: "sorciere", description: "Il est gentil")
chasseur = Character.new(name: "chasseur", description: "Il est chiant")
cupidon = Character.new(name: "cupidon", description: "Il est gniangnian")

loup1.save
loup2.save
voyante.save
sorciere.save
chasseur.save
cupidon.save

puts 'Seeding users...'
user1 = User.new(username: "User1", email: "User1@mail.fr", password: "password")
user2 = User.new(username: "User2", email: "User2@mail.fr", password: "password")
user3 = User.new(username: "User3", email: "User3@mail.fr", password: "password")
user4 = User.new(username: "User4", email: "User4@mail.fr", password: "password")
user5 = User.new(username: "User5", email: "User5@mail.fr", password: "password")

user1.save
user2.save
user3.save
user4.save
user5.save

puts 'Seeding a game...'
game = Game.new
game.save

puts 'Seeding players...'
player1 = Player.new(user: user1, character: loup1, game: game)
player2 = Player.new(user: user2, character: loup2, game: game)
player3 = Player.new(user: user3, character: voyante, game: game)
player4 = Player.new(user: user4, character: sorciere, game: game)
player5 = Player.new(user: user5, character: chasseur, game: game)

player1.save
player2.save
player3.save
player4.save
player5.save

puts 'Seed has been done'
